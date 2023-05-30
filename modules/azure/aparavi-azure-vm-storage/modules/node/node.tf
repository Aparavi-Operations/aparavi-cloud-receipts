locals {
  user_data = <<EOF
## template: jinja
#!/bin/bash
while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;

apt-get update -y
apt-get install -y transmission-daemon unzip samba
systemctl transmission-daemon stop

mkdir -p /mnt/{data,dw-dir}

cat <<EOC >> /etc/transmission-daemon/settings.json 
{
    "alt-speed-down": 50,
    "alt-speed-enabled": false,
    "alt-speed-time-begin": 540,
    "alt-speed-time-day": 127,
    "alt-speed-time-enabled": false,
    "alt-speed-time-end": 1020,
    "alt-speed-up": 50,
    "bind-address-ipv4": "0.0.0.0",
    "bind-address-ipv6": "::",
    "blocklist-enabled": false,
    "blocklist-url": "http://www.example.com/blocklist",
    "cache-size-mb": 2048,
    "dht-enabled": true,
    "download-dir": "/mnt/data",
    "download-limit": 100,
    "download-limit-enabled": 0,
    "download-queue-enabled": true,
    "download-queue-size": 5,
    "encryption": 1,
    "idle-seeding-limit": 30,
    "idle-seeding-limit-enabled": false,
    "watch-dir": "/mnt/dwl-dir",
    "watch-dir-enabled": true,
    "incomplete-dir": "/mnt/data",
    "incomplete-dir-enabled": false,
    "lpd-enabled": false,
    "max-peers-global": 400,
    "message-level": 1,
    "peer-congestion-algorithm": "",
    "peer-id-ttl-hours": 6,
    "peer-limit-global": 600,
    "peer-limit-per-torrent": 50,
    "peer-port": 51413,
    "peer-port-random-high": 65535,
    "peer-port-random-low": 49152,
    "peer-port-random-on-start": false,
    "peer-socket-tos": "default",
    "pex-enabled": true,
    "port-forwarding-enabled": true,
    "preallocation": 1,
    "prefetch-enabled": true,
    "queue-stalled-enabled": true,
    "queue-stalled-minutes": 30,
    "ratio-limit": 2,
    "ratio-limit-enabled": false,
    "rename-partial-files": true,
    "rpc-authentication-required": true,
    "rpc-bind-address": "0.0.0.0",
    "rpc-enabled": true,
    "rpc-host-whitelist": "localhost",
    "rpc-host-whitelist-enabled": false,
    "rpc-password": "{676d8b1ce50e4ba8c25025dbe89f7485595847daLa6tIYGE",
    "rpc-port": 9091,
    "rpc-url": "/transmission/",
    "rpc-username": "Aparavi",
    "rpc-whitelist": "127.0.0.1",
    "rpc-whitelist-enabled": false,
    "scrape-paused-torrents-enabled": true,
    "script-torrent-done-enabled": false,
    "script-torrent-done-filename": "",
    "seed-queue-enabled": false,
    "seed-queue-size": 10,
    "speed-limit-down": 800,
    "speed-limit-down-enabled": false,
    "speed-limit-up": 400,
    "speed-limit-up-enabled": false,
    "start-added-torrents": true,
    "trash-original-torrent-files": false,
    "umask": 18,
    "upload-limit": 100,
    "upload-limit-enabled": 0,
    "upload-slots-per-torrent": 14,
    "utp-enabled": true
}
EOC

cat <<EOC >> /etc/samba/smb.conf
[global]
security = user
passdb backend = tdbsam
workgroup = APARAVI
server string = Samba
min protocol = SMB2
bind interfaces only = yes
log level = 1

socket options = TCP_NODELAY IPTOS_LOWDELAY
read raw = Yes

strict locking = No
oplocks = yes
getwd cache = yes
server signing = No
server multi channel support = yes
allow insecure wide links = yes


[dataset-test]
follow symlinks = yes
wide links = yes
comment = Perflab share 1T
path = /mnt/data/ready
vfs objects = io_uring
browsable = yes
guest ok = no
read only = yes
write list = dataset-rw
read list = dataset-ro
create mask = 0755
EOC

systemctl enable --now transmission-daemon

useradd dataset-rw
useradd dataset-ro

echo 'Aparavi123!' | passwd --stdin dataset-rw
echo 'Aparavi123!' | passwd --stdin dataset-ro

(pdbedit --user=dataset-rw 2>&1 > /dev/null)
    || (echo 'Aparavi123!'; echo 'Aparavi123!')
    | smbpasswd -s -a dataset-rw
(pdbedit --user=dataset-ro 2>&1 > /dev/null)
    || (echo 'Aparavi123!'; echo 'Aparavi123!')
    | smbpasswd -s -a dataset-ro

(smbclient -U dataset-rw%'Aparavi123!' -L 127.0.0.1 2>&1 > /dev/null)
    || (echo 'Aparavi123!'; echo 'Aparavi123!')
    | smbpasswd dataset-rw
(smbclient -U dataset-ro%'Aparavi123!' -L 127.0.0.1 2>&1 > /dev/null)
    || (echo 'Aparavi123!'; echo 'Aparavi123!')
    | smbpasswd dataset-ro

systemctl enable --now smbd
systemctl restart smbd

# use download command
# wget --no-parent -e robots=off --recursive -l1 http://libgen.rs/scimag/repository_torrent/
EOF
}

resource "azurerm_public_ip" "node" {
  name                = "${var.name}-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "node" {
  name                = "${var.name}-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.node.id
    primary                       = true
  }
}

resource "azurerm_linux_virtual_machine" "node" {
  name          = "${var.name}-vm"
  computer_name = "${var.name}-${replace(azurerm_public_ip.node.ip_address, ".", "-")}"
  custom_data   = var.custom_data
  user_data = base64encode(local.user_data)
  //encryption_at_host_enabled = true

  tags = merge(var.tags, {
    Name         = var.name
    component    = var.component
    subcomponent = "storage"
  })

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = "aparavi"
  network_interface_ids = [
    azurerm_network_interface.node.id,
  ]

  dynamic "identity" {
    for_each = toset(var.identity)
    content {
      type         = identity.value["type"]
      identity_ids = lookup(identity.value, "identity_ids", [])
    }
  }
  admin_ssh_key {
    username   = "aparavi"
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = var.disk_size
    name                 = "${var.name}-disk"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11-gen2"
    version   = "latest"
  }
}

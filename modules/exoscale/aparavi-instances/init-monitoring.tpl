#cloud-config

package_update: true
package_upgrade: true

write_files:
  - path: /etc/network/interfaces.d/51-lan-network
    content: |
      auto eth1
      iface eth1 inet static
          address ${int_ip_address}/24
          
runcmd:
- [ sh, -c, "sudo systemctl restart networking" ]
- [ sh, -c, "curl -s https://raw.githubusercontent.com/Aparavi-Operations/aparavi-cloud-receipts/main/kvm/ansible/install_apps/install_monitoring.sh | sudo bash -s --" ]
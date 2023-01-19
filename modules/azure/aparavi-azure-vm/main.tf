locals {
  aggregator_type    = var.appagent ? "aggregator-collector" : "aggregator"
  collector_ip       = var.appagent ? "none" : module.collector[0].node_private_ip
  aggregator_install = <<EOF
#!/bin/sh

sudo echo Script started > /tmp/script.log
NODE_EXPORTER_VERSION='1.3.1'
MONITORING_BRANCH='main'
while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;
sleep 10
sudo apt install --assume-yes wget
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run 
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=${local.aggregator_type} /BINDTO="${var.platform}" /DBTYPE="mysql" /DBHOST="${module.node_db.endpoint}" /DBPORT="3306" /DBUSER="${var.db_user}@${module.node_db.endpoint}" /DBPSWD="${module.node_db.rds_password}" /SILENT /NOSTART
sed -i s/'ModuleArg="--moduleType=$AppType"'/'ModuleArg="--moduleType=$AppType --config.node.parentObjectId=${var.parent_id}"'/g /opt/aparavi-data-ia/${local.aggregator_type}/app/support/linux/startapp.sh
/opt/aparavi-data-ia/${local.aggregator_type}/app/startapp

wget -q https://raw.githubusercontent.com/Aparavi-Operations/aparavi-cloud-receipts/$${MONITORING_BRANCH}/monitoring/templates/monitoring/node_exporter.service -O /etc/systemd/system/node_exporter.service
useradd -U -r -s /usr/sbin/nologin node-exp
TEMPORARY_DIR=`mktemp -d`
wget -q https://github.com/prometheus/node_exporter/releases/download/v$${NODE_EXPORTER_VERSION}/node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -O $${TEMPORARY_DIR}/node_exporter.tar.gz
cd $${TEMPORARY_DIR}
tar xzf node_exporter.tar.gz
sudo mv ./node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/node_exporter
sudo chown root:root /usr/local/bin/node_exporter
sudo chmod 0755 /usr/local/bin/node_exporter
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
rm -rf $${TEMPORARY_DIR}
EOF

  collector_install  = var.appagent ? null : <<EOF
#!/bin/sh
sudo echo Script started > /tmp/script.log
NODE_EXPORTER_VERSION='1.3.1'
MONITORING_BRANCH='main'
while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;
sleep 10
sudo apt install --assume-yes wget
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run 
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=collector /BINDTO="${module.node.node_private_ip}" /DBTYPE="sqlite" /RDBTYPE="local" /SILENT /NOSTART
/opt/aparavi-data-ia/collector/app/startapp

wget -q https://raw.githubusercontent.com/Aparavi-Operations/aparavi-cloud-receipts/$${MONITORING_BRANCH}/monitoring/templates/monitoring/node_exporter.service -O /etc/systemd/system/node_exporter.service
useradd -U -r -s /usr/sbin/nologin node-exp
TEMPORARY_DIR=`mktemp -d`
wget -q https://github.com/prometheus/node_exporter/releases/download/v$${NODE_EXPORTER_VERSION}/node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -O $${TEMPORARY_DIR}/node_exporter.tar.gz
cd $${TEMPORARY_DIR}
tar xzf node_exporter.tar.gz
sudo mv ./node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/node_exporter
sudo chown root:root /usr/local/bin/node_exporter
sudo chmod 0755 /usr/local/bin/node_exporter
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
rm -rf $${TEMPORARY_DIR}
EOF
  worker_install  = <<EOF
#!/bin/bash
set -ex

sudo echo Script started > /tmp/script.log
NODE_EXPORTER_VERSION='1.3.1'
MONITORING_BRANCH='main'
MY_IP=`hostname -I`
echo $${MY_IP}
while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;
sleep 10
sudo apt install --assume-yes wget
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run -O linux-installer-latest.run
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=worker /BINDTO="${module.node.node_private_ip}:9745" /DBTYPE="sqlite" /RDBTYPE="local" /SILENT /NOSTART
/opt/aparavi-data-ia/worker/app/startapp

wget -q https://raw.githubusercontent.com/Aparavi-Operations/aparavi-cloud-receipts/$${MONITORING_BRANCH}/monitoring/templates/monitoring/node_exporter.service -O /etc/systemd/system/node_exporter.service
useradd -U -r -s /usr/sbin/nologin node-exp
TEMPORARY_DIR=`mktemp -d`
wget -q https://github.com/prometheus/node_exporter/releases/download/v$${NODE_EXPORTER_VERSION}/node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -O $${TEMPORARY_DIR}/node_exporter.tar.gz
cd $${TEMPORARY_DIR}
tar xzf node_exporter.tar.gz
sudo mv ./node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/node_exporter
sudo chown root:root /usr/local/bin/node_exporter
sudo chmod 0755 /usr/local/bin/node_exporter
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
rm -rf $${TEMPORARY_DIR}
EOF
  monitoring_install = <<EOF
## template: jinja
#!/bin/bash
set -ex

while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;
sleep 10
apt update
apt install --assume-yes software-properties-common git apt-transport-https ca-certificates gnupg2 curl wget
DOCKER_COMPOSE_VERSION='2.3.0'
NODE_EXPORTER_VERSION='1.3.1'
MONITORING_BRANCH='OPS-2090'

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"

apt update
apt -y install docker-ce docker-ce-cli containerd.io
systemctl enable --now docker

wget -q https://github.com/docker/compose/releases/download/v$${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose
chmod 0750 /usr/local/bin/docker-compose

cd /root && git clone https://github.com/Aparavi-Operations/aparavi-cloud-receipts.git
cd /root/aparavi-cloud-receipts && git checkout $${MONITORING_BRANCH}
cp -r /root/aparavi-cloud-receipts/monitoring/templates/monitoring /root/; cd /root/
sed -i 's/<<deployment>>/${azurerm_resource_group.main.name}/g' `find . -type f -name 'scrape_azure*.yml'`
if [[ ${local.aggregator_type} -eq "aggregator-collector" ]]; then
  sed -i 's/<<appagent_ip>>/${module.node.node_private_ip}/g' `find . -type f -name 'scrape_azure*.yml'`
elif [[ ${local.aggregator_type} -eq "aggregator" ]]; then
  sed -i 's/<<aggregator_ip>>/${module.node.node_private_ip}/g' `find . -type f -name 'scrape_azure*.yml'`
  sed -i 's/<<collector_ip>>/${local.collector_ip}/g' `find . -type f -name 'scrape_azure*.yml'`
fi
sed -i 's/<<monitoring_ip>>/{{ ds.meta_data.imds.network.interface[0].ipv4.ipAddress[0].privateIpAddress }}/g' `find . -type f -name 'scrape_azure*.yml'` 
if [[ ${var.workers} ]]; then
  rm /root/monitoring/vmagent/scrape_azure.yml
  sed -i 's/<<worker_1_ip>>/${module.workers[0].node_private_ip}/g' /root/monitoring/vmagent/scrape_azure_workers.yml
  sed -i 's/<<worker_2_ip>>/${module.workers[1].node_private_ip}/g' /root/monitoring/vmagent/scrape_azure_workers.yml
  sed -i 's/<<worker_3_ip>>/${module.workers[2].node_private_ip}/g' /root/monitoring/vmagent/scrape_azure_workers.yml
else
  rm /root/monitoring/vmagent/scrape_azure_workers.yml
fi
rm /root/monitoring/vmagent/scrape_ec2.yml
rm /root/monitoring/vmagent/scrape_gcp.yml
cp /root/monitoring/aparavi-monitoring.service /etc/systemd/system/aparavi-monitoring.service
systemctl daemon-reload
systemctl enable aparavi-monitoring
systemctl start aparavi-monitoring

useradd -U -r -s /usr/sbin/nologin node-exp
TEMPORARY_DIR=`mktemp -d`
wget -q https://github.com/prometheus/node_exporter/releases/download/v$${NODE_EXPORTER_VERSION}/node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -O $${TEMPORARY_DIR}/node_exporter.tar.gz
cd $${TEMPORARY_DIR}
tar xzf node_exporter.tar.gz
mv ./node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/node_exporter
chown root:root /usr/local/bin/node_exporter
chmod 0755 /usr/local/bin/node_exporter
cp /root/monitoring/node_exporter.service /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
rm -rf $${TEMPORARY_DIR}
EOF
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "main" {
  name     = "${var.name}-rg"
  location = var.location
}

module "network" {
  source                  = "./modules/network"
  name                    = var.name
  vnet_cidr               = var.vnet_cidr
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  tags                    = var.tags
}

module "bastion" {
  source                  = "./modules/bastion"
  name                    = var.name
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  vm_subnet               = module.network.public_subnet
  vm_size                 = var.bastion_size
  ssh_key                 = var.ssh_key
  tags                    = var.tags
}

module "node" {
  source                  = "./modules/node"
  name                    = var.appagent ? "${var.name}-appagent" : "${var.name}-aggregator"
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  vm_subnet               = module.network.public_subnet
  vm_size                 = var.node_size
  ssh_key                 = var.ssh_key
  disk_size               = var.appagent ? var.collector_storage_size + 50 : ceil(var.collector_storage_size / 3) + 50
  custom_data             = base64encode(local.aggregator_install)
  fw_ports = {
    "data" = {
      "priority" = 200,
      "port"     = 9545,
    },
    "node_forwarder" = {
      "priority" = 210,
      "port"     = 9100,
    }
  }
  tags = var.tags
}

module "collector" {
  count                   = var.appagent ? 0 : 1
  source                  = "./modules/node"
  name                    = "${var.name}-collector"
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  vm_subnet               = module.network.public_subnet
  vm_size                 = var.collector_size
  ssh_key                 = var.ssh_key
  disk_size               = var.collector_storage_size + 50
  custom_data             = base64encode(local.collector_install)
  fw_ports = {
    "node_forwarder" = {
      "priority" = 210,
      "port"     = 9100,
    }
  }
  tags = var.tags
}

module "workers" {
  count                   = var.appagent ? var.workers ? 3 : 0 : 0
  source                  = "./modules/node"
  name                    = "${var.name}-worker-${count.index}"
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  vm_subnet               = module.network.public_subnet
  vm_size                 = var.workers_size
  ssh_key                 = var.ssh_key
  disk_size               = var.workers_storage_size + 50
  custom_data             = base64encode(local.worker_install)
  fw_ports = {
    "node_forwarder" = {
      "priority" = 210,
      "port"     = 9100,
    }
  }
  tags = var.tags
}

locals {
  db_access_ips = var.workers ? {
    appagent = "${module.node.node_public_ip}"
    worker1 = "${module.workers[0].node_public_ip}"
    worker2 = "${module.workers[1].node_public_ip}"
    worker3 = "${module.workers[2].node_public_ip}"
  } : {
    appagent = "${module.node.node_public_ip}"
  }
}

module "node_db" {
  source                  = "./modules/database"
  name                    = var.appagent ? "${var.name}-appagentdb" : "${var.name}-aggregatordb"
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  db_shape                = var.db_shape
  db_size                 = ceil(var.collector_storage_size / 2) * 1024
  db_user                 = var.db_user
  db_access_ips           = local.db_access_ips
  tags                    = var.tags
}

module "monitoring" {
  source                  = "./modules/node"
  name                    = "${var.name}-monitoring"
  resource_group_location = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  vm_subnet               = module.network.public_subnet
  vm_size                 = var.monitoring_size
  ssh_key                 = var.ssh_key
  disk_size               = 30
  custom_data             = base64encode(local.monitoring_install)
  identity = [
    { type = "SystemAssigned" }
  ]
  fw_ports = {
    "grafane" = {
      "priority" = 200,
      "port"     = 80,
      "source"   = "*"
    },
    "vmagent" = {
      "priority" = 210,
      "port"     = 8429,
    }
  }
  tags = var.tags
}

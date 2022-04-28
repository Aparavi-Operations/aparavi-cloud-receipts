== Azure example

```
#!/bin/sh
sudo echo Script started > /tmp/script.log
sudo apt install --assume-yes git apt-transport-https ca-certificates gnupg2 curl wget software-properties-common
WORK_DIR=`mktemp -d`
DOCKER_COMPOSE_VERSION='2.3.0'

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

sudo wget -q https://github.com/docker/compose/releases/download/v$${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64 -O /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod 0750 /usr/local/lib/docker/cli-plugins/docker-compose
cd /root && git clone https://github.com/Aparavi-Operations/aparavi-cloud-receipts.git
cd /root/monitoring && git checkout monitoring

sed -i 's/<<deployment>>/${azurerm_resource_group.main.name}}/g' /root/monitoring/vmagent/scrape_azure.yml
sed -i 's/<<aggregator_ip>>/${module.aggregator.node_private_ip}/g' /root/monitoring/vmagent/scrape_azure.yml
sed -i 's/<<collector_ip>>/${module.collector.node_private_ip}/g' /root/monitoring/vmagent/scrape_azure.yml
sed -i 's/<<monitoring_ip>>/127.0.0.1/g' /root/monitoring/vmagent/scrape_azure.yml
rm /root/monitoring/vmagent/scrape_ec2.yml

cp /root/monitoring/aparavi-monitoring.service /etc/systemd/system/aparavi-monitoring.service

useradd -U -r -s /usr/sbin/nologin node-exp
TEMPORARY_DIR=`mktemp -d`


systemctl enable aparavi-monitoring
systemctl start aparavi-monitoring
```

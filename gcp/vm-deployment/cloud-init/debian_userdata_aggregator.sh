#!/bin/sh
sudo echo Script started > /tmp/script.log
sudo apt install --assume-yes  wget
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run 
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=aggregator /BINDTO="${platform_bind_addr}" /DBTYPE="mysql" /DBHOST="${db_addr}" /DBPORT="3306" /DBUSER="${db_user}" /DBPSWD="${db_passwd}" /SILENT /NOSTART
sed -i s/'ModuleArg="--moduleType=$AppType"'/'ModuleArg="--moduleType=$AppType --config.node.parentObjectId=${parentId}"'/g /opt/aparavi-data-ia/aggregator/app/support/linux/startapp.sh
/opt/aparavi-data-ia/aggregator/app/startapp

#install node_exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
sudo mv node_exporter-*.*-amd64/node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter

echo >

/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
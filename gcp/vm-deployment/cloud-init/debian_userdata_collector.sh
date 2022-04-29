#!/bin/sh
sudo echo Script started > /tmp/script.log
sudo apt install --assume-yes  wget
sudo echo installed wget >> /tmp/script.log
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run
sudo echo downloaded installer >> /tmp/script.log
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=collector /BINDTO="10.105.10.51" /DBTYPE="sqlite" /RDBTYPE='local' /SILENT

#install node_exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
sudo mv node_exporter-*.*-amd64/node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter

sudo cat <<EOF > /etc/systemd/system/node_exporter.service
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
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
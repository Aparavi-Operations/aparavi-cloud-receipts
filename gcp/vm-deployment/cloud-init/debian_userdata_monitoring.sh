#!/bin/sh
sudo echo Script started > /tmp/script.log
sudo apt update
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

sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo mkdir /opt/monitoring-stack
sudo mkdir /vmagentdata
sudo mkdir /storage
sudo mkdir /etc/vmalert
sudo mkdir /var/lib/grafana
sudo mkdir /etc/grafana/
sudo mkdir /etc/alertmanager/
sudo cat <<EOF > /opt/monitoring-stack/docker-compose.yaml
---

version: '3.5'
services:
  vmagent:
    container_name: vmagent
    image: victoriametrics/vmagent
    depends_on:
      - "victoriametrics"
    ports:
      - 8429:8429
    volumes:
      - vmagentdata:/vmagentdata
      - ./vmagent/:/etc/vmagent/
    command:
      - '--promscrape.config=/etc/vmagent/vmagent.yml'
      - '--remoteWrite.url=http://victoriametrics:8428/api/v1/write'
    networks:
      - vm_net
    extra_hosts:
      - 'host.docker.internal:host-gateway'
    restart: on-failure
  victoriametrics:
    container_name: victoriametrics
    image: victoriametrics/victoria-metrics
    ports:
      - 8428:8428
      - 8089:8089
      - 8089:8089/udp
      - 2003:2003
      - 2003:2003/udp
      - 4242:4242
    volumes:
      - vmdata:/storage
    command:
      - '--storageDataPath=/storage'
      - '--graphiteListenAddr=:2003'
      - '--opentsdbListenAddr=:4242'
      - '--httpListenAddr=:8428'
      - '--influxListenAddr=:8089'
    networks:
      - vm_net
    restart: on-failure
  grafana:
    container_name: grafana
    image: grafana/grafana:8.4.3
    depends_on:
      - "victoriametrics"
    ports:
      - 80:3000
    volumes:
      - grafanadata:/var/lib/grafana
      - ./grafana/:/etc/grafana/
    networks:
      - vm_net
    restart: on-failure
  vmalert:
    container_name: vmalert
    image: victoriametrics/vmalert
    depends_on:
      - "victoriametrics"
      - "alertmanager"
    ports:
      - 8880:8880
    volumes:
      - ./vmalert/:/etc/vmalert/
    command:
      - '--datasource.url=http://victoriametrics:8428/'
      - '--remoteRead.url=http://victoriametrics:8428/'
      - '--remoteWrite.url=http://victoriametrics:8428/'
      - '--notifier.url=http://alertmanager:9093/'
      - '--rule=/etc/vmalert/*.yml'
      # display source of alerts in grafana
      - '-external.url=http://127.0.0.1:3000' #grafana outside container
    networks:
      - vm_net
    restart: on-failure
  alertmanager:
    container_name: alertmanager
    image:  prom/alertmanager
    volumes:
      - ./alertmanager/:/etc/alertmanager/
    command:
      - '--config.file=/etc/alertmanager/config.yml'
    ports:
      - 9093:9093
    networks:
      - vm_net
    restart: on-failure
volumes:
  vmagentdata: {}
  vmdata: {}
  grafanadata: {}
networks:
  vm_net:
EOF
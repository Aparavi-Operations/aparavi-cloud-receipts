#!/bin/bash -x

sudo cat <<EOF > /tmp/debian11_infrastructure.yml
---
- name: Debian 11 Aparavi
  hosts: 
    - "all"
  become: true
  gather_facts: true
  roles:
    - os_hardening
    - ssh_hardening
EOF

apt-get update
apt-get install software-properties-common -y
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible git 
ansible-galaxy collection install devsec.hardening
export ANSIBLE_ROLES_PATH=/root/.ansible/collections/ansible_collections/devsec/hardening/roles/
export ANSIBLE_HOST_KEY_CHECKING=false
ansible-playbook /tmp/debian11_infrastructure.yml --connection=local -i 127.0.0.1, -v

sudo echo Script started > /tmp/script.log
sudo apt install --assume-yes  wget
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run 
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=aggregator-collector /BINDTO="${platform_bind_addr}" /DBTYPE="mysql" /DBHOST="${db_addr}" /DBPORT="3306" /DBUSER="${db_user}" /DBPSWD="${db_passwd}" /SILENT /NOSTART
sed -i s/'ModuleArg="--moduleType=$AppType"'/'ModuleArg="--moduleType=$AppType --config.node.parentObjectId=${parentId}"'/g /opt/aparavi-data-ia/aggregator-collector/app/support/linux/startapp.sh
/opt/aparavi-data-ia/aggregator-collector/app/startapp

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



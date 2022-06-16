#cloud-config

package_update: true
package_upgrade: true

write_files:
  - path: /etc/network/interfaces.d/51-lan-network
    content: |
      auto eth1
      iface eth1 inet static
          address ${int_ip_address}/24
  - path: /opt/debian_userdata_monitoring.sh
    content: |
      #!/bin/sh
      set -ex
      sudo echo Script started > /tmp/script.log
      sudo apt update
      sudo apt install --assume-yes  wget
      sudo apt install --assume-yes  git

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
      systemctl daemon-reload
      systemctl enable node_exporter
      systemctl start node_exporter


      while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;
      sleep 10
      apt update
      apt install --assume-yes software-properties-common git apt-transport-https ca-certificates gnupg2 curl wget
      DOCKER_COMPOSE_VERSION='2.3.0'
      NODE_EXPORTER_VERSION='1.3.1'
      MONITORING_BRANCH='OPS-1261_create_exoscale_vm'

      curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
      add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"

      apt update
      apt -y install docker-ce docker-ce-cli containerd.io
      systemctl enable --now docker

      wget -q https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose
      chmod 0750 /usr/local/bin/docker-compose

      cd /root && git clone https://github.com/Aparavi-Operations/aparavi-cloud-receipts.git
      cd /root/aparavi-cloud-receipts && git checkout OPS-1261_create_exoscale_vm
      cp -r /root/aparavi-cloud-receipts/monitoring/templates/monitoring /root/
      rm -f /root/monitoring/vmagent/scrape_azure.yml
      rm -f /root/monitoring/vmagent/scrape_ec2.yml
      rm -f /root/monitoring/vmagent/scrape_kvm.yml
      rm -f /root/monitoring/vmagent/scrape_gcp.yml
      sed -i 's/<<deployment>>/aparavi-exoscale/g' /root/monitoring/vmagent/scrape_exoscale.yml
      sed -i 's/<<appagent_ip>>/192.168.100.5/g' /root/monitoring/vmagent/scrape_exoscale.yml
      sed -i 's/<<monitoring_ip>>/192.168.100.6/g' /root/monitoring/vmagent/scrape_exoscale.yml
      cp /root/monitoring/aparavi-monitoring.service /etc/systemd/system/aparavi-monitoring.service
      systemctl daemon-reload
      systemctl enable aparavi-monitoring
      systemctl start aparavi-monitoring

runcmd:
- [ sh, -c, "sudo systemctl restart networking" ]
- [ sh, -c, "sudo chmod +x /opt/debian_userdata_monitoring.sh" ]
- [ sh, -c, "sudo /opt/debian_userdata_monitoring.sh" ] 
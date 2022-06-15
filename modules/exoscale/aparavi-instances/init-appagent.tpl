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
      sudo echo Script started > /tmp/script.log
      sudo apt install --assume-yes  wget
      wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run 
      chmod +x linux-installer-latest.run
      ./linux-installer-latest.run -- /APPTYPE=aggregator-collector /BINDTO="${platform_bind_addr}" /DBTYPE="mysql" /DBHOST="${db_addr}" /DBPORT="${db_port}" /DBUSER="${db_user}" /DBPSWD="${db_passwd}" /SILENT /NOSTART
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

    
runcmd:
- [ sh, -c, "sudo systemctl restart networking" ]
- [ sh, -c, "sudo chmod +x /opt/debian_userdata_monitoring.sh" ]
- [ sh, -c, "sudo /opt/debian_userdata_monitoring.sh" ]
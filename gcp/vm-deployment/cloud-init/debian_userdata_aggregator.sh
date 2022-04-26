#!/bin/sh
sudo echo Script started > /tmp/script.log
sudo apt install --assume-yes  wget
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run 
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=aggregator /BINDTO="${platform_bind_addr}" /DBTYPE="mysql" /DBHOST="${db_addr}" /DBPORT="3306" /DBUSER="${db_user}" /DBPSWD="${db_passwd}" /SILENT /NOSTART
sed -i s/'ModuleArg="--moduleType=$AppType"'/'ModuleArg="--moduleType=$AppType --config.node.parentObjectId=${parentId}"'/g /opt/aparavi-data-ia/aggregator/app/support/linux/startapp.sh
/opt/aparavi-data-ia/aggregator/app/startapp
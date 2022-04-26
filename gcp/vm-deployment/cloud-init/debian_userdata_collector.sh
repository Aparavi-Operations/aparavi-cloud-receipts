#!/bin/sh
sudo echo Script started > /tmp/script.log
sudo apt install --assume-yes  wget
sudo echo installed wget >> /tmp/script.log
wget https://aparavi.jfrog.io/artifactory/aparavi-installers-public/linux-installer-latest.run
sudo echo downloaded installer >> /tmp/script.log
chmod +x linux-installer-latest.run
./linux-installer-latest.run -- /APPTYPE=collector /BINDTO="10.105.10.51" /DBTYPE="sqlite" /RDBTYPE='local' /SILENT
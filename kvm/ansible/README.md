This set of ansible playbooks will install Aparavi app stack to baremetal machines with libvirt virtual machines
please run in this order:
1. ***install_libvirt*** folder:
```run ansible-playbook playbook.yaml -i inventory.yaml```
this will install libvirt and bridge network interfaces with NAT
2. ***install_apps*** folder:
download cloud template from debian (we have used https://cloud.debian.org/images/cloud/bullseye/20220503-998/debian-11-generic-amd64-20220503-998.qcow2) and place it inside this folder
install requirements.txt
run
```pip install requirements.txt```
You can configure vm settings(disk size, swap size, cpu cores number, memory size, hostname) and vm number in inventory.yaml file  
to set up vms run 
```ansible-playbook playbook.yaml -i inventory.yaml```
this will install virtual machine.
By default this will install Aparavi AppAgent instance and Aparavi monitoring setup
3. ***set_portforward*** folder:
this will set porforwarding as vm instances are placed behuind NAT and we need to connect AppAgent to monitoring stack
define addresses and ports in inventory.yaml and run 
```ansible-playbook playbook.yaml -i inventory.yaml```
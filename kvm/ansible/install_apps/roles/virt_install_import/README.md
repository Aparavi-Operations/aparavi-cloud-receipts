# Ansible Role: virt_install_import

An ansible role to import virtual machine with the ```virt-install import``` command

## Requirements

virt-install

## Role Variables

### Playbook related variables

* **virt_install_import**: "namespace"
  * **name**: required. The name of the virtual machine
  * **autostart**: optional default: true. Enable autostart.
  * **wait**: optional default: 0. The ```--wait``` option for the ```virt-install```
    command. A negative value will wait still the virtmachine is shutdown.
    0 will just start the virtual machine and disconnect. 
  * **memory**: optional, default 1024 The virtual machine memory
  * **vcpu**: optional, default 1. The number of virtual cpu cores.
  * **virt_type**: optional, default: kvm.  The hypervisor type.
  * **graphics**: optional, default: none. The graphical display configuration.
  * **os_type**: optional, default: not defined. The operating system type.
  * **os_variant**: optional, default: not defined. The operating system variant.
  * **network**: optional, default: not defined. The network string
  * **disks**: optional, default: not defined. The disk strings.

## Dependencies

None

## Example Playbooks

### Import a virtual machine
 
```
---
- name: Import a virtual machine
  gather_facts: no 
  become: true
  hosts: localhost
  roles:
    - role: stafwag.virt_install_import
      vars:
        virt_install_import:
          wait: -1
          name: tstdebian2
          os_type: Linux
          os_variant: debian10
          network: network:default
          graphics: spice
          disks:
            - /var/lib/libvirt/images/tstdebian2.qcow2,device=disk
            - /var/lib/libvirt/images/tstdebian2_cloudinit.iso,device=cdrom
```


## License

MIT/BSD

## Author Information

Created by Staf Wagemakers, email: staf@wagemakers.be, website: http://www.wagemakers.be.

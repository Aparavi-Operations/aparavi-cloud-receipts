#cloud-config

package_update: true
package_upgrade: true

write_files:
  - path: /etc/network/interfaces.d/51-lan-network
    content: |
      auto ens6
      iface ens6 inet static
          address ${int_ip_address}/24
          
runcmd:
- [ sh, -c, "sudo systemctl restart networking" ]
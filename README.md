# nixos-config

## Installation of DNS Files:
- Create directory `/var/dns/`
- Change owner of `/var/dns/` to `0660`
- Symlink `./server/zones/main.rillonautikum.internal` to `/var/dns/mainzone`
- Change owner of `/var/dns/mainzone` to `named:named`
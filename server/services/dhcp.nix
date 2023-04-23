{ config, pkgs, ... }:

{
  services.dhcpd4 = {
    enable = true;
    interfaces = [ "main" "test" "app" "enp2s0" ];
    extraConfig = ''
      include "/mnt/certs/tsig.key";

      ddns-updates on;
      ddns-update-style interim;
      update-static-leases on;
      ignore client-updates;

      zone main.rillonautikum.internal. {
        primary 127.0.0.1;
        key tsig-key;
      }

      zone app.rillonautikum.internal. {
        primary 127.0.0.1;
        key tsig-key;
      }

      zone 10.in-addr.arpa. {
        primary 127.0.0.1;
        key tsig-key;
      }

      subnet 10.0.0.0 netmask 255.255.248.0 {
        range 10.0.0.20 10.0.0.200;
        interface enp2s0;
        default-lease-time 3600;
        max-lease-time 7200;
        option subnet-mask 255.255.248.0;
        option broadcast-address 10.0.15.255;
        option routers 10.0.0.1;
        option domain-name "legacy.rillonautikum.internal";
        option domain-search "legacy.rillonautikum.internal";
        option domain-name-servers 10.0.0.1;
      }

      subnet 10.0.16.0 netmask 255.255.248.0 {
        range 10.0.16.20 10.0.16.200;
        interface main;
        default-lease-time 3600;
        max-lease-time 7200;
        option subnet-mask 255.255.248.0;
        option broadcast-address 10.0.23.255;
        option routers 10.0.16.1;
        option domain-name "main.rillonautikum.internal";
        option domain-search "main.rillonautikum.internal";
        option domain-name-servers 10.0.16.1;
      }
      
      subnet 10.0.32.0 netmask 255.255.248.0 {
        range 10.0.32.20 10.0.32.200;
        interface test;
        default-lease-time 3600;
        max-lease-time 7200;
        option subnet-mask 255.255.248.0;
        option broadcast-address 10.0.47.255;
        option routers 10.0.32.1;
        option domain-name-servers 10.0.32.1;
      }

      subnet 10.0.24.0 netmask 255.255.248.0 {
        range 10.0.24.20 10.0.24.200;
        interface app;
        default-lease-time 3600;
        max-lease-time 7200;
        option subnet-mask 255.255.248.0;
        option broadcast-address 10.0.31.255;
        option routers 10.0.24.1;
        option domain-name "app.rillonautikum.internal";
        option domain-search "app.rillonautikum.internal";
        option domain-name-servers 10.0.24.1;
      }
    '';
  };
}
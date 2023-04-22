{ config, pkgs, ... }:

{
  services.dhcpd4 = {
    enable = true;
    interfaces = [ "main" "test" ];
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

      zone 10.in-addr.arpa. {
        primary 127.0.0.1;
        key tsig-key;
      }

      subnet 10.0.16.0 netmask 255.255.240.0 {
        range 10.0.16.20 10.0.16.200;
        interface main;
        default-lease-time 3600;
        max-lease-time 7200;
        option subnet-mask 255.255.240.0;
        option broadcast-address 10.0.23.255;
        option routers 10.0.16.1;
        option domain-name "main.rillonautikum.internal";
        option domain-search "main.rillonautikum.internal";
        option domain-name-servers 10.0.16.1;
      }
      
      subnet 10.0.32.0 netmask 255.255.240.0 {
        range 10.0.32.20 10.0.32.200;
        interface test;
        default-lease-time 3600;
        max-lease-time 7200;
        option subnet-mask 255.255.240.0;
        option broadcast-address 10.0.47.255;
        option routers 10.0.32.1;
        option domain-name-servers 10.0.32.1;
      }
    '';
  };
}
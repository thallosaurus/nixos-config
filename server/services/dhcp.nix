{ config, pkgs, ... }:

{
  services.dhcpd4 = {
    enable = true;
    interfaces = [ "main" ];
    extraConfig = ''
      subnet 10.0.16.0 netmask 255.255.240.0 {
        range 10.0.16.20 10.0.16.200;
        interface main;
        default-lease-time 3600;
        max-lease-time 7200;
        option domain-name-servers 10.0.16.1;
        option subnet-mask 255.255.240.0;
        option broadcast-address 10.0.23.255;
        option routers 10.0.16.1;
        option domain-search main.rillonautikum.internal;
      }
    '';
  };
}
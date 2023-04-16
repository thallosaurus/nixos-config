{ config, pkgs, ... }:

{
  services.dhcpd4.machines = [
    {
      ethernetAddress = "e8:48:b8:47:03:af";
      hostName = "root-switch";
      ipAddress = "10.0.16.2";
    }
  ];
}
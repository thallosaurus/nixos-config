{ config, pkgs, ... }:

{
  services.dhcpd4.machines = [
    {
      ethernetAddress = "e8:48:b8:47:03:af";
      hostName = "root-switch";
      ipAddress = "10.0.16.2";
    }
    {
      ethernetAddress = "14:98:77:4f:35:d2";
      hostName = "cyberpsych0siis";
      ipAddress = "10.0.16.3";
    }
  ];
}
{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "172.16.0.1"
    ];

    zones = [
      {
        name = "main.rillonautikum.internal";
        file = "/mnt/dns/main.rillonautikum";
        master = true;
      }
    ];

  };

  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}

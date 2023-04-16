{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "172.16.0.1"
    ];

    networking.firewall.allowedTCPPorts = [ 23 ];
    networking.firewall.allowedUDPPorts = [ 23 ];

    zones = [
      {
        name = "main.rillonautikum.internal";
        file = "/root/nixos-config/server/zones/main.rillonautikum";
        master = true;
      }
    ];

  };
}

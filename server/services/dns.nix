{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "172.16.0.1"
    ];

    zones = {
      main.rillonautikum.internal = {
        file = "";
        master = true;
      }
    };
  };
}

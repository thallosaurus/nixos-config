{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "172.16.0.1"
    ];

    zones = {
      main = {
        "main.rillonautikum.internal" = {
          file = "/var/dns/rillonautikum.internal";
          master = true;
        };
      };
    };

  };
}

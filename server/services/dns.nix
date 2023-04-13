{ config, pkgs, ... }:

{
  /*users.users.bind = {
    isSystemUser = true;
    description = "bind";
    group = "bind";
    packages = with pkgs; [
      #  thunderbird
      bind
    ];
  };*/

  systemd.user.services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "172.16.0.1"
    ];

    zones = [
      {
        name = "main.rillonautikum.internal";
        file = "/var/dns/main.rillonautikum.internal";
        master = true;
      }
    ];

  };
}

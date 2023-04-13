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
        file = "/var/dns/main.rillonautikum.internal";
        master = true;
      }
    ];

  };

  users.users.bind = {
    isNormalUser = false;
    description = "bind";
    group = "bind";
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}

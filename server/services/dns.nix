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
        file = "/mnt/dns/main.rillonautikum.internal";
        master = true;
      }
    ];
  };

  environment.etc = {
    "dns/mainzone" =
    {
      text = (builtins.readFile ../zones/main.rillonautikum.internal);
      mode = "0660";
      user = "named";
      group = "named";
    };
  };

  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}

{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "172.16.0.1"
    ];

    extraOptions = ''
      allow-query-cache { localhost; localnets; };

      allow-recursion { localhost; localnets; };
      allow-transfer { localhost; };
    '';

    extraConfig = ''
      include "/mnt/certs/tsig.key";

      acl acl-name { 
        any;
      };
    '';

    zones = [
      {
        name = "main.rillonautikum.internal";
        file = "/etc/dns/zones/mainzone";
        master = true;
        slaves = [
          "key 'tsig-key'"
        ];
      }
    ];
  };

  environment.etc = {
    "dns/zones/mainzone" =
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

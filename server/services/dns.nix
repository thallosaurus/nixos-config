{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    ipv4Only = true;
    forwarders = [
      "1.1.1.1" # will be changed to uncensored ip i think
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
      # mainnet
      {
        name = "main.rillonautikum.internal";
        file = "/mnt/config/dns/mainzone";
        master = true;
        slaves = [
          "key 'tsig-key'"
        ];
        extraConfig = ''
          allow-update {key "tsig-key";};
        '';
      }
      {
        name = "10.in-addr.arpa";
        file = "/mnt/config/dns/mainzone.reverse";
        master = true;
        slaves = [
          "key 'tsig-key'"
        ];
        extraConfig = ''
          allow-update {key "tsig-key";};
        '';
      }

      # Appnet
      {
        name = "app.rillonautikum.internal";
        file = "/mnt/config/dns/appzone";
        master = true;
        slaves = [
          "key 'tsig-key'"
        ];
        extraConfig = ''
          allow-update {key "tsig-key";};
        '';
      }
    ];
  };

  #environment.etc = {
  /*"dns/zones/mainzone" =
      {
        text = (builtins.readFile ../zones/main.rillonautikum.internal);
        mode = "0660";
        user = "named";
        group = "named";
      };
  };*/

  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}

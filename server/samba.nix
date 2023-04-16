{ config, pkgs, ... }:

{
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  services.samba.openFirewall = true;

  services.samba = {
    enable = true;

    # $ sudo smbpasswd -a yourusername

    # This adds to the [global] section:
    extraConfig = ''
      browseable = yes
    '';

    shares = {
      homes = {
        browseable = "no"; # note: each home will be browseable; the "homes" share will not.
        "read only" = "no";
        "guest ok" = "no";
      };
      Archive = {
        "path" = "/mnt/archive";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
      };
      "Samples And Stuff" = {
        "path" = "/mnt/stuff";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
      };
      "Certificates" = {
        "path" = "/mnt/certs";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };



  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];



  # To make SMB mounting easier on the command line
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];



  # mDNS
  #
  # This part may be optional for your needs, but I find it makes browsing in Dolphin easier,
  # and it makes connecting from a local Mac possible.
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };


  /*private = {
        path = "/mnt/Shares/Private";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "username";
        "force group" = "groupname";
      };*/
}

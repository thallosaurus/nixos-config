{ config, pkgs, ... }:

{
  boot.kernel.sysctl = {
  # if you use ipv4, this is all you need
  "net.ipv4.conf.all.forwarding" = true;

  # If you want to use it for ipv6
  #"net.ipv6.conf.all.forwarding" = true;

  # source: https://github.com/mdlayher/homelab/blob/master/nixos/routnerr-2/configuration.nix#L52
  # By default, not automatically configure any IPv6 addresses.
  #"net.ipv6.conf.all.accept_ra" = 0;
  #"net.ipv6.conf.all.autoconf" = 0;
  #"net.ipv6.conf.all.use_tempaddr" = 0;

  # On WAN, allow IPv6 autoconfiguration and tempory address use.
  #"net.ipv6.conf.${name}.accept_ra" = 2;
  #"net.ipv6.conf.${name}.autoconf" = 1;

  networking = {
  useDHCP = false;
  hostName = "router";
  nameserver = [ 172.16.0.1 ];
  # Define VLANS
  vlans = {
    main = {
      id = 10;
      interface = "enp2s0";
    };
    test = {
      id = 30;
      interface = "enp2s0";
    };
  };



  interfaces = {
    # Don't request DHCP on the physical interfaces
    enp1s0.useDHCP = false;
    enp1s0.ipv4.addresses = [ {
      address = 172.16.0.2;
      prefixLength = 23;
    }];


    enp2s0.useDHCP = false;
    
    # Handle the VLANs
    wan.useDHCP = false;
    main = {
      ipv4.addresses = [{
        address = "10.0.16.1";
        prefixLength = 20;
      }];
    };
    test = {
      ipv4.addresses = [{
        address = "10.0.24.1";
        prefixLength = 20;
      }];
    };
  };
};
};
}
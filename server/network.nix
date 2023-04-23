{ config, pkgs, ... }:

{
  imports = [
    ./services/dhcp.nix
  ];

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
  };

  /*services.miniupnpd = {
    enable = true;
    externalInterface = "enp1s0"; # WAN
    internalIPs = [ "main" "test" ]; # LAN
  };*/

  networking = {
    useDHCP = false;
    hostName = "router";
    nameservers = [ "1.1.1.1" ];
    defaultGateway = "172.16.0.1";
    # Define VLANS
    vlans = {
      main = {
        id = 10;
        interface = "enp2s0";
      };
      app = {
        id = 20;
        interface = "enp2s0";
      };
      test = {
        id = 30;
        interface = "enp2s0";
      };
    };

/*    nat.enable = true;

    nat.externalInterface = "enp1s0";
    nat.internalInterfaces = [ "main" "app" "test" ];*/

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        443
      ];
      allowedUDPPorts = [
        37949
      ];
      extraCommands = ''
        iptables -t nat -A POSTROUTING -o enp1s0 -j MASQUERADE

        # Default filter FORWARD policy - dont allow by default that devices can reach devices in other subnets
        iptables -t filter -P FORWARD DROP

        # Allow Legacy In
        #iptables -t filter -A FORWARD -i enp1s0 -j ACCEPT

        # Allow Legacy In
        #iptables -t filter -A FORWARD -o enp1s0 -j ACCEPT
        
        # Allow outgoing Packets from legacy to wan
        iptables -t filter -A FORWARD -i enp2s0 -o enp1s0 -j ACCEPT

        # Allow incoming Packets to main from legacy
        iptables -t filter -A FORWARD -i enp1s0 -o enp2s0 -j ACCEPT
        
        # Allow outgoing Packets from main to wan
        iptables -t filter -A FORWARD -i main -o enp1s0 -j ACCEPT

        # Allow incoming Packets to main from wan
        iptables -t filter -A FORWARD -i enp1s0 -o main -j ACCEPT

        # Allow outgoing Packets from test to wan
        iptables -t filter -A FORWARD -i test -o enp1s0 -j ACCEPT

        # Allow incoming Packets to test from wan
        iptables -t filter -A FORWARD -i enp1s0 -o test -j ACCEPT

        # Allow outgoing Packets from app to wan
        iptables -t filter -A FORWARD -i app -o enp1s0 -j ACCEPT

        # Allow incoming Packets to app from wan
        iptables -t filter -A FORWARD -i enp1s0 -o app -j ACCEPT
      '';
    };

    interfaces = {
      # Don't request DHCP on the physical interfaces
      enp1s0.useDHCP = false;
      enp1s0.ipv4.addresses = [{
        address = "172.16.0.2";
        prefixLength = 23;
      }];


      enp2s0.useDHCP = false;
      enp2s0.ipv4.addresses = [{
        address = "10.0.0.1";
        prefixLength = 21;
      }];

      # Handle the VLANs
      main = {
        ipv4.addresses = [{
          address = "10.0.16.1";
          prefixLength = 21;
        }];
      };
      app = {
        ipv4.addresses = [{
          address = "10.0.24.1";
          prefixLength = 21;
        }];
      };
      test = {
        ipv4.addresses = [{
          address = "10.0.32.1";
          prefixLength = 21;
        }];
      };
    };
  };
}

{ config, pkgs, ... }:
{
  networking = {
    useDHCP = true;
    # Define VLANS
    vlans = {
      app = {
        id = 20;
        interface = "enp4s0";
      };
    };
  };
}

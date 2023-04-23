{ config, pkgs, ... }:
{
  networking = {
    useDHCP = true;
    # Define VLANS
    vlans = {
      app = {
        id = 10;
        interface = "enp4s0";
      };
    };
  };
}

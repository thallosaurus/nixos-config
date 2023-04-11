{ config, ... }:    
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include the package list.
      ./packages.nix
      ./samba.nix
    ];
  # SOME STUFF
  # SOME STUFF
}

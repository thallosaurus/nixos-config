{ config, pkgs, ... }:
{
  users.users.akasha = {
    isNormalUser = true;
    description = "akasha";
    extraGroups = [ "networkmanager" "wheel" "smbusers" "akasha" "named" ];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

    users.groups.akasha = {};

}

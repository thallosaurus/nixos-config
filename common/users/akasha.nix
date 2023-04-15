{ config, pkgs, ... }:
{
  users.users.akasha = {
    isNormalUser = true;
    description = "akasha";
    extraGroups = [ "networkmanager" "wheel" "smbusers" ];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

}

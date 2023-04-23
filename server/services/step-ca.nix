{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #   wget
    step-ca
    step-cli
  ];

  /*services.step-ca = {
    enable = true;
    port = 443;
    address = "10.0.16.1";
    openFirewall = true;
    intermediatePasswordFile = "/mnt/config/smallstep-password";
    settings = builtins.fromJSON (builtins.readFile "/root/.step/config/ca.json");
  };*/
}
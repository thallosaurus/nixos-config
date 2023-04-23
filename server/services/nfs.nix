{ config, pkgs, ... }:
{
  fileSystems."/export/cofig" = {
    device = "/mnt/config";
    options = [ "bind" ];
  };

  services.nfs.server = {
    services.nfs.server.enable = true;
    #/export         192.168.1.10(rw,fsid=0,no_subtree_check) 192.168.1.15(rw,fsid=0,no_subtree_check)
    services.nfs.server.exports = ''
      /export/config  10.0.0.0/21(rw,nohide,insecure,no_subtree_check)
    '';

    enable = true;
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  };

  networking.firewall = {
    enable = true;
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };
}

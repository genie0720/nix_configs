{ config, pkgs, lib, ... }:

{
  # Mount for NFS
   fileSystems."/swarm" = {
   device = "/dev/sdb1";
   fsType = "ext4"; # Change this based on your filesystem type
   };
   fileSystems."/export/swarm" = {
   device = "/swarm";
   options = [ "bind" ];
   };

   services.nfs.server.enable = true;
   services.nfs.server.exports = ''
     /export         192.168.20.4(rw,fsid=0,no_subtree_check,no_root_squash) 192.168.20.5(rw,fsid=0,no_subtree_check,no_root_squash) 192.168.20.11(rw,fsid=0,no_subtree_check,no_root_squash)
     /export/swarm   192.168.20.4(rw,nohide,insecure,no_subtree_check,no_root_squash) 192.168.20.5(rw,nohide,insecure,no_subtree_check,no_root_squash) 192.168.20.11(rw,nohide,insecure,no_subtree_check,no_root_squash)
    '';
}
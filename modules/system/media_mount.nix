{ config, pkgs, lib, ... }:

{
   # Mount Media
  fileSystems."/media" = {
  device = "/dev/disk/by-uuid/f6b97f59-fe9f-4f69-aaf3-45fa2b356a59";
  fsType = "ext4";
  options = [ "defaults" ];
  };
  
}
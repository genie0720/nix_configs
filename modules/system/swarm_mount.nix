{ config, pkgs, lib, ... }:

{
  # Mount for NFS
    fileSystems."/swarm" = {
    device = "192.168.20.3:/swarm";
    fsType = "nfs";
  };
  
}
{ config, pkgs, lib, ... }:

{
  fileSystems."/media" = {
    device = "//192.168.20.5/media"; # replace 'share' with your SMB share name
    fsType = "cifs";
    options = [
      "credentials=/etc/smb-credentials"
      "uid=1000"
      "gid=100"
      "file_mode=0644"
      "dir_mode=0755"
      "vers=3.0"
    ];
  };
}
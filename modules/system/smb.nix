{ smb_path, smb_name, smb_test, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ samba ];

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "nixos-smb";
        "netbios name" = "nixos-smb";
        security = "user";
      };
      "${smb_name}" = {
        path = smb_path;
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";  # Set to "no" if you want authentication
        "valid users" = "nix";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  # Optional: Advertise shares to Windows hosts
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # Ensure the shared directory exists
  systemd.tmpfiles.rules = [
    smb_test
  ];


}
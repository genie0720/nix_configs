{ config, pkgs, ... }:

{
  users.users.nix = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "nix";
    extraGroups = [ "networkmanager" "docker" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpGEHz5GiF9R0hvgdXk1XasYO/MQDkNSfoZZ0O9Katy"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0Ki5/j2JS6Aiovc8SrNuC5rKVwwVcaXmsOTIWHpD8B"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOegr5/PUD0cKYghDDTv99e09gx2gXReQYj6h9OZiYk"
    ];
  };
}

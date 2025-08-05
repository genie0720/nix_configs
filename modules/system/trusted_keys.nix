{ config, pkgs, lib, ... }:

{
nix.settings.trusted-public-keys = [
    "my-cache-key:KNZDnopAjPp1qt0xgc4yqXveXVUSYVaSUg86NdgVmVM=%"
  ];
  nix.settings.trusted-users = [ "nix" ];
}
{ config, pkgs, ... }:

{
  imports = [
    ./check-capslock.nix
    ./status.nix

  ];
}

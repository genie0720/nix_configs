{ config, pkgs, ... }:

{
  imports = [
    ./env.nix
    ./execs.nix
    ./general.nix
    ./hyprbars.nix
    ./keybinds.nix
    ./rules.nix

  ];
}

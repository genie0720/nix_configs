{ config, pkgs, ... }:

{
  imports = [
    ./chromatic_abberation.nix
    ./crt.nix
    ./drugs.nix
    ./extradark.nix
    ./invert.nix
    ./solarized.nix
  ];
}

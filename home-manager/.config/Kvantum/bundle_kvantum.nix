{ config, pkgs, ... }:

{
  imports = [
    ./Colloid/Colloid.nix
    ./Colloid/ColloidDark.nix
    ./MaterialAdw/MaterialAdw.nix

  ];
}

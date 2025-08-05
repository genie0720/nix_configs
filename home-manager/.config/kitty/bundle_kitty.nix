{ config, pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./scroll_mark.nix
    ./search.nix

  ];
}

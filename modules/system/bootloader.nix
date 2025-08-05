{ config, pkgs, lib, ... }:
{
 # Bootloader settings
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";  # Make sure to parameterize or override per-host if needed
    useOSProber = true;
  };
}
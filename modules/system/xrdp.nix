{ config, pkgs, lib, ... }:

{
environment.systemPackages = with pkgs; [
    x11vnc
  ];

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.x11vnc}/bin/x11vnc -forever -display :0 -rfbauth /home/youruser/.vnc/passwd &
  '';

}

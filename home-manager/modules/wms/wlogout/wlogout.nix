{ config, ... }:

{
  home.file."${config.home.homeDirectory}/.config/wlogout/layout".text = builtins.toJSON ''
  [lock]
  label=Lock
  command=${config.home.homeDirectory}/.config/swaylock/lock.sh

  [reboot]
  label=Reboot
  command=systemctl reboot
  '';
}

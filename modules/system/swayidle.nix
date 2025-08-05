{ config, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "timeout";
        timeout = 300;
        command = "/home/genie/.config/swaylock/lock.sh";
      }
      {
        event = "timeout";
        timeout = 600;
        command = "swaymsg \"output * dpms off\"";
        resumeCommand = "swaymsg \"output * dpms on\"";
      }
      {
        event = "before-sleep";
        command = "/home/genie/.config/swaylock/lock.sh";
      }
    ];
  };
}
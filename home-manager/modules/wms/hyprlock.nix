{ config, ... }:

{
home.file."${config.home.homeDirectory}/.config/hypr/hyprlock.conf".text = ''
  general {
    grace = 1
    fractional_scaling = 2
    immediate_render = true
  }

background {
  color = rgba(0, 0, 0, 0.3)
  blur_passes = 3
}


  input-field {
    size = 300, 60
    placeholder_text = <span foreground="##cdd6f4"><i>🔒 Type Password</i></span>
    hide_input = false
    halign = center
    valign = bottom
  }
'';

home.file."${config.home.homeDirectory}/.config/hypr/hypridle.conf".text = ''
  general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
  }

  listener {
    timeout = 300
    on-timeout = loginctl lock-session
  }
'';

}
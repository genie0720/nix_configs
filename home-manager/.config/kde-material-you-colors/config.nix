{ config, pkgs, lib, ... }:

{
  home.file.".config/kde-material-you-colors/config.conf".text = ''
    [CUSTOM]
    # INSTRUCTIONS
    # Run kde-material-you-colors with no arguments from terminal
    # to debug your configuration changing in real time.

    # Monitor to get wallpaper from
    monitor = 0

    # File containing absolute path of an image
    file = ~/.local/state/quickshell/user/generated/wallpaper/path.txt

    # List of 7 space separated colors (hex or rgb)
    custom_colors_list = #ED8796 #A6DA95 #EED49F #8AADF4 #F5BDE6 #8BD5CA #f5a97f

    # Alternative color mode
    ncolor = 0

    # Light scheme icons theme
    iconslight = breeze-plus

    # Dark scheme icons theme
    iconsdark = breeze-plus-dark

    # Use pywal to theme other programs
    pywal=False

    # Scheme Variant
    scheme_variant = 5

    # Colorfulness
    chroma_multiplier = 1

    # Brightness
    tone_multiplier = 1
  '';
}

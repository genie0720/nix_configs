{ pkgs, inputs, ... }:

let
  desktopApps = with pkgs; [
    audacity alacritty rofi wofi mpv discord gparted obsidian pcmanfm-qt polymc
    swaylock-effects hyprlock microsoft-edge nemo joplin-desktop
  ];

  devTools = with pkgs; [
    gnumake gcc nodejs python
    (python3.withPackages (ps: with ps; [ requests ]))
  ];

  cliTools = with pkgs; [
    neofetch file tree fastfetch htop nix-index unzip scrot ffmpeg light lux
    mediainfo ranger zram-generator cava zip ntfs3g brightnessctl swww lazygit
    bluez bluez-tools
  ];

  guiUtils = with pkgs; [
    feh imv dmenu screenkey mako gromit-mpx wlogout libinput
  ];

  waylandTools = with pkgs; [
    xwayland wl-clipboard cliphist grim grimblast slurp flameshot swappy
    herbstluftwm hyprland seatd xdg-desktop-portal-hyprland polybar waybar
  ];

  audioStack = with pkgs; [
    pipewire pulseaudio pamixer
  ];

  miscTools = with pkgs; [
    spice-vdagent libsForQt5.qtstyleplugin-kvantum libsForQt5.qt5ct
    papirus-nord home-manager pcsclite ccid opensc pcsc-tools nss
  ];

  fontPackages = with pkgs; [
    jetbrains-mono noto-fonts noto-fonts-emoji twemoji-color-font
    font-awesome powerline-fonts powerline-symbols
    nerd-fonts.symbols-only material-symbols
  ];

  extraCerts = [
    ../../certs/Certificates_PKCS7_v5_14_DoD.der.p7b
    ../../certs/Certificates_PKCS7_v5_14_DoD_DoD_Root_CA_3.der.p7b
    ../../certs/Certificates_PKCS7_v5_14_DoD_DoD_Root_CA_4.der.p7b
    ../../certs/Certificates_PKCS7_v5_14_DoD_DoD_Root_CA_5.der.p7b
    ../../certs/Certificates_PKCS7_v5_14_DoD_DoD_Root_CA_6.der.p7b
    ../../certs/Certificates_PKCS7_v5_14_DoD.pem.p7b
  ];
in
{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "python-2.7.18.8"
      "electron-25.9.0"
    ];
  };

  environment.systemPackages =
    desktopApps ++ devTools ++ cliTools ++ guiUtils ++ waylandTools ++ audioStack ++ miscTools ++ [ inputs.zen-browser.packages.${pkgs.system}.default ];
  fonts.packages = fontPackages;

  services.pcscd.enable = true;
  security.pam.p11.enable = true;
  security.pki.certificateFiles = [
    ../../certs/Certificates_PKCS7_v5_14_DoD.pem.p7b # only takes `pem` files
  ];

  system.activationScripts.installCACCerts.text = ''
    mkdir -p /etc/cac-certs
    cp ${builtins.concatStringsSep " " (map toString extraCerts)} /etc/cac-certs/
  '';
}
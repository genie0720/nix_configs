{
  home.file.".config/zshrc.d/dots-hyprland.zsh".text = ''
    # Use the generated color scheme
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt; then
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    fi
  '';
}

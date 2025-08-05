{ pkgs, ... }: {
    programs.zsh = {
    enable = true;
    enableCompletion = true;
    # syntaxHighlighting.enable = true;
    # autosuggestion.enable = true;
    history.size = 10000;
    shellAliases = {
      ns = "sudo nixos-rebuild switch --flake /home/genie/config#asusnix";
      nrs = "sudo nixos-rebuild switch --flake /home/genie/config#genienix";
      nrs1 = "sudo nixos-rebuild switch --flake /home/genie/config#nix01 --target-host root@192.168.20.3";
      nrs2 = "sudo nixos-rebuild switch --flake /home/genie/config#nix02 --target-host root@192.168.20.4";
      nrs3 = "sudo nixos-rebuild switch --flake /home/genie/config#nix03 --target-host root@192.168.20.5";
    };
    sessionVariables = {
      SSH_AUTH_SOCK = "/home/genie/.bitwarden-ssh-agent.sock";
  };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "extract" "sudo" ];
      theme = "fino-time"; # Or another theme you like
    };
  };

  # Add autosuggestions and syntax highlighting as packages
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  # Source plugins manually
  programs.zsh.initContent = ''
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # Show username@hostname followed by current working directory and a $ or #
    # PROMPT='%n@%m %~ %# '

  '';
}
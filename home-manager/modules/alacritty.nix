{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.60;

      font = {
        size = 15.0;
        # draw_bold_text_with_bright_colors = true;
        normal = {
          family = "JetBrains Mono";
          style = "Bold";
        };
      };

      colors.primary.background = "#1d2021";
    };
  };
}
{ config, ... }:

{
  home.file."${config.home.homeDirectory}/.config/wlogout/style.json".text = builtins.toJSON {
    window = {
      background-color = "#282c34";
      border-radius = 10;
    };
    label = {
      text-color = "#ffffff";
    };
    button = {
      background-color = "#3c4048";
      hover-color = "#4c5058";
      text-color = "#ffffff";
    };
  };
}

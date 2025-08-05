{ config, pkgs, lib, ... }:

{
  home.file.".config/wlogout/style.css".text = ''
    * {
      all: unset;
      background-image: none;
      transition: all 300ms ease-in-out;
    }

    window {
      background-color: rgba(0, 0, 0, 0.70);  /* 🔸 More transparent = more blur if supported by compositor */
      border-radius: 12px;                  /* Optional rounding for cleaner blur edges */
    }

    button {
      font-family: "Material Symbols Outlined", sans-serif;
      font-size: 64px;
      background-color: rgba(20, 20, 20, 0.3);  /* 🔸 Softer button backdrop */
      color: #ffffff;
      margin: 6px;
      border-radius: 12px;
      padding: 16px 20px;
      min-width: 72px;
      min-height: 72px;
    }

    button:hover,
    button:focus,
    button:active {
      background-color: rgba(80, 80, 80, 0.4);
      border-radius: 16px;
    }
  '';
}






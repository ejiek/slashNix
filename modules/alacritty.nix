{
  config,
  pkgs,
  ...
}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      # Not sure is this is still needed
      #
      # This value is used to set the `$TERM` environment variable for
      # each instance of Alacritty. If it is not present, alacritty will
      # check the local terminfo database and use 'alacritty' if it is
      # available, otherwise 'xterm-256color' is used.
      TERM = "xterm-256color";
      padding = {
        x = 2;
        y = 2;
      };
      dynamic_padding = true;
      decorations = "none";
      dynamic_title = true;
      unfocused_hollow = true;
      key_bindings = [
        {
          key = "PageUp";
          mods = "Shift";
          action = "ScrollPageUp";
        }
        {
          key = "PageDown";
          mods = "Shift";
          action = "ScrollPageDown";
        }
        {
          key = "End";
          mods = "Shift";
          action = "ScrollToBottom";
        }
        {
          key = "Home";
          mods = "Shift";
          action = "ScrollToTop";
        }
      ];
      colors = {
        primary = {
          background = "#fbf1c7";
          foreground = "#3c3836";
        };
        normal = {
          black = "#fbf1c7";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#9d0006";
          green = "#79740e";
          yellow = "#b57614";
          blue = "#076678";
          magenta = "#8f3f71";
          cyan = "#427b58";
          white = "#3c3836";
        };
        dim = {
          black = "#333333";
          red = "#f2777a";
          green = "#99cc99";
          yellow = "#ffcc66";
          blue = "#6699cc";
          magenta = "#cc99cc";
          cyan = "#66cccc";
          white = "#d3d0c8";
        };
      };
    };
  };
}

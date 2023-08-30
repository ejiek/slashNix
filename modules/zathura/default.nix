{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    zathura.enable = mkOption {
      description = "Enable my customized zathura";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.zathura.enable {
    home-manager.users.ejiek = {
      home.packages = [ pkgs.zathura ];
      home.file = {
        "./.config/zathura/zathurarc".text = ''
          set selection-clipboard clipboard

          #set colours od Zathura itself
          set default-bg "#7c6f64"

          # Set colours of the document
          set recolor		true
          set recolor-darkcolor	"#3c3836"
          set recolor-lightcolor	"#fbf1c7"
        '';
      };
    };
  };
}

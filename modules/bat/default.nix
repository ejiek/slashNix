{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    bat.enable = mkOption {
      description = "Enable my customized bat (nicer cat)";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.bat.enable {
    home-manager.users.ejiek = {
      programs.bat = {
        enable = true;
        config = {
          theme = "gruvbox-light";
        };
      };
    };
  };
}

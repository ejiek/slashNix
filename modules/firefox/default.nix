{ config, lib, pkgs, ... }:
let
  inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    firefox.enable = mkOption {
      description = "Enable firefox";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.firefox.enable {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = [
        pkgs.tridactyl-native
      ];
    };
    # home-manager.users.ejiek = {
    #   programs.firefox = {
    #     enable = true;
    #   };
    # };
  };
}

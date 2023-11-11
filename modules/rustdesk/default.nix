{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    rustdesk.enable = mkOption {
      description = "Enable rustdesk";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.obsidian.enable {
    environment.systemPackages = with pkgs; [ rustdesk ];
    nixpkgs.allowUnfreePackages = [ "libsciter" ];
  };
}

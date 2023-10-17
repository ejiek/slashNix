{ lib, pkgs, config, ... }:
{
  options = with lib; {
    pkgs.allowUnfreePackages = mkOption {
      type = with types; listOf str;
      default = [];
      example = [ "steam" "steam-original" "steam-run" ];
    };
  };

  config = {
    #lib.nixosSystem.pkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.pkgs.allowUnfreePackages;
  };
}

{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    podman.enable = mkOption {
      description = "Enable my customized podman";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.podman.enable {
    virtualisation = {
      podman = {
        enable = true;
        # Create a `docker` alias
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      containers.storage.settings.storage = {
        driver = "overlay";
        # could be a separate pool/dataset
        graphroot = "/home/ejiek/.local/share/containers/storage";
        rootless_storage_path = "/home/ejiek/.local/share/containers/storage";
        runroot = "/run/containers/storage";
      };
    };

    environment.systemPackages = with pkgs; [
      podman-compose
    ];

    # Enable native overlay diff
    # Might not be necessary with current config
    boot.extraModprobeConfig = ''
      options overlay metacopy=off redirect_dir=off
    '';
  };
}

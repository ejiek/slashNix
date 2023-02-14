{
  pkgs,
  ... }:

{
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # enable ZFS storage driver & docker-compose compatibility
      extraPackages = with pkgs; [ podman-compose zfs ];

      # There is an auto prune option available
    };

    containers.storage.settings.storage = {
      driver = "zfs";
      # could be a separate pool/dataset
      graphroot = "/var/lib/containers";
      runroot = "/run/containers";
    };
  };
}

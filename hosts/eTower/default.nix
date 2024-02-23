# configuration in this file only applies to exampleHost host
#
# only my-config.* and zfs-root.* options can be defined in this file.
#
# all others goes to `configuration.nix` under the same directory as
# this file.

{ system, pkgs, ... }: {
  inherit pkgs system;
  zfs-root = {
    boot = {
      devNodes = "/dev/disk/by-id/";
      bootDevices = [ "ata-WDC_WDS250G2B0A-00SM50_2021AA445312" "ata-WDC_WDS250G2B0A-00SM50_2021AA446401"];
      immutable = false;
      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "e1000e" ];
      removableEfi = true;
      kernelParams = [ ];
      sshUnlock = {
        # read sshUnlock.txt file.
        enable = true;
        authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwNC63godvuNujA/a83sdbwFXrdid69TTy5QM7u237o ejiek@ePower" ];
      };
    };
    networking = {
      # read changeHostName.txt file.
      hostName = "eTower";
      timeZone = "Europe/Moscow";
      hostId = "6cf655a7";
    };
  };

  # To add more options to per-host configuration, you can create a
  # custom configuration module, then add it here.
  my-config = {
    cli_tools.enable = true;
    git.enable = true;
    joshuto.enable = true;
    nvim.enable = true;
    nu.enable = true;
    podman.enable = true;
    starship.enable = true;
    tailscale.enable = true;
    zsh.enable = true;
  };
}

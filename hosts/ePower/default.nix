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
      bootDevices = [  "nvme-Samsung_SSD_970_PRO_512GB_S463NF0M902919V" ];
      immutable = false;
      availableKernelModules = [  "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      removableEfi = true;
      kernelParams = [ ];
      sshUnlock = {
        # read sshUnlock.txt file.
        enable = false;
        authorizedKeys = [ ];
      };
    };
    networking = {
      # read changeHostName.txt file.
      hostName = "ePower";
      timeZone = "Europe/Moscow";
      hostId = "58f85363";
    };
  };

  # To add more options to per-host configuration, you can create a
  # custom configuration module, then add it here.
  my-config = {
    alacritty.enable = true;
    bat.enable = true;
    git.enable = true;
    hypr.enable = true;
    nvim.enable = true;
    nu.enable = true;
    obsidian.enable = true;
    opentabletdriver.enable = true;
    pass.enable = true;
    podman.enable = true;
    rbw.enable = true;
    rofi.enable = true;
    qutebrowser.enable = true;
    starship.enable = true;
    steam.enable = true;
    tailscale.enable = true;
    zathura.enable = true;
    zsh.enable = true;
  };
}

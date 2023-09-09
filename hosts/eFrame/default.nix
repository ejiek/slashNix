# only my-config.* and zfs-root.* options can be defined in this file.
#
# all others goes to `configuration.nix` under the same directory as
# this file.

{ system, pkgs, ... }: {
  inherit pkgs system;
  zfs-root = {
    boot = {
      devNodes = "/dev/disk/by-id/";
      bootDevices = [ "nvme-Samsung_SSD_990_PRO_2TB_S6Z2NF0W715587R" ];
      immutable = false;
      availableKernelModules = [  "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
      removableEfi = true;
      kernelParams = [ ];
      xone = true;
      sshUnlock = {
        enable = false;
        authorizedKeys = [ ];
      };
    };
    networking = {
      hostName = "eFrame";
      timeZone = "Europe/Moscow";
      hostId = "06de2282";
    };
  };

  my-config = {
    alacritty.enable = true;
    apple-tethering.enable = true;
    bat.enable = true;
    git.enable = true;
    hypr = {
      enable = true;
      layout = "dwindle";
      monitors = ''
        monitor=,highres,auto,2
        env = GDK_SCALE,2
        env = XCURSOR_SIZE,16
      '';
    };
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
    zsh.enable = true;
  };

  security.polkit.enable = true;
}

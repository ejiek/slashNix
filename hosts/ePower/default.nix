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
    bluetooth.enable = true;
    cli_tools.enable = true;
    git.enable = true;
    hypr = {
      enable = true;
      monitors = [
        ",preferred,auto,auto"
        "HDMI-A-1,preferred,auto,auto,transform,1"
      ];
      workspaces = [
        "1, monitor:DP-2, default:true"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1, default:true"
      ];
      paperConfig = ''
        ipc = off
        preload = /home/ejiek/pictures/bg.jpg
        preload = /home/ejiek/pictures/bg-right.jpg
        wallpaper = DP-2,contain:/home/ejiek/pictures/bg.jpg
        wallpaper = HDMI-A-1,contain:/home/ejiek/pictures/bg-right.jpg
      '';
    };
    joshuto.enable = true;
    nvim.enable = true;
    nu.enable = true;
    obs.enable = true;
    obsidian.enable = true;
    opentabletdriver.enable = true;
    pass.enable = true;
    podman.enable = true;
    rbw.enable = true;
    rofi.enable = true;
    qutebrowser.enable = true;
    spotify.enable = true;
    starship.enable = true;
    steam.enable = true;
    tailscale.enable = true;
    xone.enable = true;
    zathura.enable = true;
    zsh.enable = true;
  };
}

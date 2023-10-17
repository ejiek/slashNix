{ config, pkgs, lib, inputs, rust-overlay, modulesPath, ... }:{
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
    xone.enable = true;
    zathura.enable = true;
    zsh.enable = true;
  };

  networking.useDHCP = true;
  networking.networkmanager.enable = false;

  # configuration in this file only applies to exampleHost host.
  programs.tmux = {
    enable = true;
    newSession = true;
    terminal = "tmux-direct";
  };
  services.emacs.enable = false;

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.fwupd.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    bitwarden
    chromium
    cider
    fira
    fira-code
    fira-mono
    firefox
    gimp
    go
    helix
    inkscape
    k9s
    kind
    krita
    kubectl
    libimobiledevice
    libwebp
    mattermost-desktop
    mpv
    nodejs
    obs-studio
    pandoc
    pulumi-bin
    pw-volume
    tdesktop
    transmission
    trivy
    virt-manager
    wireshark
    xdg-utils
  ];

  programs.wireshark.enable = true;

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ({ pkgs, ... }: {
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default pkgs.gcc ];
    })
  ];
}

{ config, pkgs, lib, inputs, rust-overlay, modulePath, ... }: {
  zfs-root = {
    boot = {
      devNodes = "/dev/disk/by-id/";
      bootDevices = [ "nvme-Samsung_SSD_990_PRO_2TB_S6Z2NF0W715587R" ];
      immutable = false;
      availableKernelModules = [  "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
      removableEfi = true;
      kernelParams = [ ];
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
    cli_tools.enable = true;
    apple-tethering.enable = true;
    bat.enable = true;
    bluetooth.enable = true;
    git.enable = true;
    hypr = {
      enable = true;
      layout = "dwindle";
      monitors = [
        "monitor=,highres,auto,2"
      ];
      cursor.size = 24;
      extraConfig = "env = GDK_SCALE,2";
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

  security.polkit.enable = true;

  # networking.useDHCP = true;
  networking.networkmanager.enable = true;

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

  services.logind = {
    powerKey = "ignore";
  };

  services.udev.extraHwdb = ''
  evdev:atkbd:dmi:bvn*:bvr*:bd*:svnFramework:pnLaptop*12thGenIntelCore*:pvr*
    KEYBOARD_KEY_3a=esc
    KEYBOARD_KEY_01=capslock
  '';

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    bitwarden
    chromium
    cider
    figlet
    fira
    fira-code
    fira-mono
    firefox
    fluffychat
    gimp
    go
    helix
    inkscape
    k9s
    kind
    krita
    kubectl
    libwebp
    mattermost-desktop
    mpv
    nodejs
    pandoc
    pulumi-bin
    pw-volume
    tdesktop
    transmission
    trivy
    virt-manager
    wireshark
    wluma
    xdg-utils
  ];

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.framework-12th-gen-intel
    ({ pkgs, ... }: {
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default pkgs.gcc ];
    })
  ];
}

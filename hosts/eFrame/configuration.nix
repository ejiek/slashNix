{ pkgs, nixos-hardware, rust-overlay, ... }: {
  imports = [
    nixos-hardware.nixosModules.framework-12th-gen-intel
    ({ pkgs, ... }: {
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default pkgs.gcc ];
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # networking.useDHCP = true;
  networking.networkmanager.enable = true;

  services.logind = {
    powerKey = "ignore";
  };

  services.udev = {
    packages = [ pkgs.crda ];
    extraHwdb = ''
    evdev:atkbd:dmi:bvn*:bvr*:bd*:svnFramework:pnLaptop*12thGenIntelCore*:pvr*
      KEYBOARD_KEY_3a=esc
      KEYBOARD_KEY_01=capslock
    '';
  };

  services.fwupd.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  hardware.flipperzero.enable = true;

  environment.systemPackages = with pkgs; [
    aichat
    bitwarden
    chromium
    cider
    crda
    figlet
    fira
    fira-code
    fira-mono
    fluffychat
    fw-ectool
    gimp
    go
    helix
    inkscape
    inotify-tools
    iw
    k9s
    kind
    krita
    kubectl
    libwebp
    linux-firmware
    mattermost-desktop
    mpv
    nodejs
    nodePackages.live-server
    pandoc
    pulumi-bin
    qFlipper
    tdesktop
    transmission
    trivy
    virt-manager
    wireguard-tools
    wireguard-vanity-address
    wireless-regdb
    wireshark
    wluma
  ];
}

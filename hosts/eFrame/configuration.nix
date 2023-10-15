{ pkgs, nixos-hardware, rust-overlay, ... }: {
  imports = [
    nixos-hardware.nixosModules.framework-12th-gen-intel
    ({ pkgs, ... }: {
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default pkgs.gcc ];
    })
  ];

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
}

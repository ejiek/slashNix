{ pkgs, rust-overlay, ... }: {
  imports = [
    ({ pkgs, ... }: {
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default pkgs.gcc ];
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  networking.useDHCP = true;
  networking.networkmanager.enable = false;

  # configuration in this file only applies to exampleHost host.
  programs.tmux = {
    enable = true;
    newSession = true;
    terminal = "tmux-direct";
  };
  services.emacs.enable = false;

  services.fwupd.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    aichat
    alsa-scarlett-gui
    audacity
    bitwarden
    calibre
    chromium
    cider
    fira
    fira-code
    fira-mono
    firefox
    tridactyl-native
    gimp
    go
    google-drive-ocamlfuse
    helix
    inkscape
    k9s
    kind
    kooha
    krita
    kubectl
    libimobiledevice
    libwebp
    mattermost-desktop
    mpv
    nodejs
    pandoc
    pulumi-bin
    tdesktop
    transmission
    trivy
    wireguard-tools
    wireguard-vanity-address
    wireshark
  ];

  programs.wireshark.enable = true;
}

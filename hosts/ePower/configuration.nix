{ pkgs, rust-overlay, ... }: {
  imports = [
    ({ pkgs, ... }: {
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default pkgs.gcc ];
    })
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

  environment.systemPackages = with pkgs; [
    bitwarden
    calibre
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
    pandoc
    pulumi-bin
    tdesktop
    transmission
    trivy
    virt-manager
    wireshark
  ];

  programs.wireshark.enable = true;
}

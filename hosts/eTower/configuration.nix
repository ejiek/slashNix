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

  services.fwupd.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    wireguard-tools
    wireguard-vanity-address
  ];
}

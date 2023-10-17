# configuration in this file is shared by all hosts

{ pkgs, inputs, ... }:
let inherit (inputs) self;
in {

  users.users = {
    root = {
      initialHashedPassword = "$6$5cnzOSUXr4kqB3fv$yYX0obtz4jhVWo0HFm963JpY0lhq8SUfzJ5092WV7mMI402Z7upb27h0aqrkmO9SV6OhwG2gd9zwANpkMG3CZ/";
      openssh.authorizedKeys.keys = [ "sshKey_placeholder" ];
    };
  };

  users.users.ejiek = {
    initialHashedPassword = "!";
    isNormalUser = true;
    extraGroups = [
      "libvirtd"
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.ejiek = {
    home.username = "ejiek";
    home.stateVersion = "23.05";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  boot.zfs.forceImportRoot = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.git.enable = true;

  security = {
    doas.enable = true;
    sudo.enable = false;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      cryptsetup
    ;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; })
      noto-fonts-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Hack" ];
        sansSerif = [ "Hack" ];
        monospace = [ "FiraCode" ];
        emoji = [ "NotoColorEmoji" ];
      };
    };
  };

  system.configurationRevision = if (self ? rev) then
    self.rev
  else
    throw "refuse to build: git tree is dirty";

  system.stateVersion = "23.05";
  # let nix commands follow system nixpkgs revision
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  networking.nftables.enable = true;
  networking.firewall.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

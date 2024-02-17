# configuration in this file is shared by all hosts

{ pkgs, ... }: {

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
    home.stateVersion = "23.11";
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
    doas = {
      enable = true;
      extraRules = [{
        users = ["ejiek"];
        persist = true;
      }];
    };
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
        serif = [ "Hack Nerd Font" ];
        sansSerif = [ "Hack Nerd Font" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
        emoji = [ "NotoColorEmoji" ];
      };
    };
  };

  i18n = {
    defaultLocale = "en_GB.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.utf8";
      LC_IDENTIFICATION = "en_GB.utf8";
      LC_MEASUREMENT = "en_GB.utf8";
      LC_MONETARY = "en_GB.utf8";
      LC_NAME = "en_GB.utf8";
      LC_NUMERIC = "en_GB.utf8";
      LC_PAPER = "en_GB.utf8";
      LC_TELEPHONE = "en_GB.utf8";
      LC_TIME = "en_GB.utf8";
    };
  };

  #nixpkgs.config.allowUnfree = false;

  networking.nftables.enable = true;
  networking.firewall.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

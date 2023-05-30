{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    pass = {
      enable = true;
      stores = [ "/home/ejiek/.local/share/password-store" ];
    };
    plugins = with pkgs; [
      rofi-emoji
    ];
  };

  home.packages = with pkgs; [
    rofi-rbw
    rofimoji
  ];
}

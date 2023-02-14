{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  programs.gpg = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  #user.packages = [ pkgs.pinentry-curses ];
}

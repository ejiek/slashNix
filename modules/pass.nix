{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };
}

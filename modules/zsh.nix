{
  config,
  pkg,
  ...
}:

# Some aliases have functions to implement them.
# I haven't figured out how to use them yet.
#
# Regular config chunks to migrate later:
#
###### Dictionary ######
#
#   alias trans='__trans'
#   alias def='__def'
#   __trans() {
#   	sdcv --color --data-dir /usr/share/stardict/dic/trans/ $* | less -R
#   }
#   __def() {
#   	sdcv --color --data-dir /usr/share/stardict/dic/def/ $* | less -R
#   }
#
###### oui lookup ######
#
#   alias oui='__oui'
#   __oui() {
#   	grep $* -i /usr/share/nmap/nmap-mac-prefixes
#   }
#
###### weather ######
# 
#   alias wttr="__wttr"
#   __wttr() {
#     curl "wttr.in/$*"
#   }

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    history = {
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    shellAliases = {
      add-deleted="git status | grep 'deleted' | awk '{ print $2 }' | xargs git add";
      jqp="jq -C | less -R";
      la="ls -lA --color";
      maps="telnet mapscii.me";
      nwitch="sudo nixos-rebuild switch --flake /home/ejiek/.slashNix/flake.nix#e220";
      sdfailed="systemctl list-units --failed";
      ssproxy="ssh -D 1080 -C -q -N";
      suspendless="systemd-inhibit --what=handle-lid-switch sleep infinity";
    };
    initExtra = ''
      bindkey -e
      # Searches for lines with same beginning
      autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search

      bindkey -- "^P" up-line-or-beginning-search
      bindkey -- "^N" down-line-or-beginning-search
    '';
    profileExtra = ''
      if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec Hyprland
      fi
    '';
  };
}


{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    hypr.enable = mkOption {
      description = "Enable my customized Hypr desktop";
      type = types.bool;
      default = false;
    };
    hypr.layout = mkOption {
      description = "master or dwindle layout";
      type = types.enum ["dwindle" "master"];
      default = "master";
    };
  };

  # if my-config.template.desktop.gnome.enable is set to true
  # set the following options
  config = mkIf config.my-config.hypr.enable {
    programs.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };

    security.pam.services.swaylock = {};

    home-manager.users.ejiek = {
      home.packages =
        builtins.attrValues { inherit (pkgs) swaylock grim; };

        gtk = {
          enable = true;
          font = { name = "sans-serif"; };
          theme = {
            name = "Adwaita";
            package = pkgs.gnome.gnome-themes-extra;
          };
          iconTheme = {
            package = pkgs.gnome.adwaita-icon-theme;
            name = "Adwaita";
          };
        };

        home.pointerCursor = {
          package = pkgs.nordzy-cursor-theme;
          name = "Nordzy-cursors";
          gtk.enable = true;
        };

        home.file = {
          "./.config/hypr/hyprland.conf".text = ''
          monitor=,preferred,auto,auto
          monitor=HDMI-A-1,preferred,auto,auto,transform,1

          xwayland {
            force_zero_scaling = true
          }

          input {
            kb_layout = us,ru
            kb_variant =
              kb_model =
                kb_options = grp:caps_toggle,grp_led:caps
                kb_rules =

                  follow_mouse = 1

                  touchpad {
                    natural_scroll = true
                  }

                  sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
                }

                general {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more

              gaps_in = 5
              gaps_out = 20
              border_size = 2
              col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
              col.inactive_border = rgba(595959aa)

              layout = ${config.my-config.hypr.layout}
            }

            decoration {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more

              rounding = 5
              blur {
                enabled = yes
                size = 3
                passes = 1
                new_optimizations = on
              }

              drop_shadow = yes
              shadow_range = 4
              shadow_render_power = 3
              col.shadow = rgba(1a1a1aee)
            }

            animations {
              enabled = yes

              # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              bezier = myBezier, 0.05, 0.9, 0.1, 1.05

              animation = windows, 1, 7, myBezier
              animation = windowsOut, 1, 7, default, popin 80%
              animation = border, 1, 10, default
              animation = fade, 1, 7, default
              animation = workspaces, 1, 6, default
            }

            dwindle {
              # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
              pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = yes # you probably want this
              no_gaps_when_only = true
            }

            master {
              # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
              new_is_master = false
              no_gaps_when_only = true
              orientation = center
            }

            gestures {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              workspace_swipe = true
            }

          # Example per-device config
          # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
          device:epic mouse V1 {
            sensitivity = -0.5
          }

          # Example windowrule v1
          # windowrule = float, ^(kitty)$
          # Example windowrule v2
          # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
          # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
          windowrule=move 100%-260 20,title:^(HealthBar)(.*)$
          windowrule=noblur,title:^(HealthBar)(.*)$
          windowrule=nofocus,title:^(HealthBar)(.*)$
          windowrule=noshadow,title:^(HealthBar)(.*)$
          windowrule=noborder,title:^(HealthBar)(.*)$
          windowrule=pin,title:^(HealthBar)(.*)$

          # See https://wiki.hyprland.org/Configuring/Keywords/ for more
          $mainMod = SUPER

          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = $mainMod, Return, exec, alacritty
          bind = $mainMod, Space, exec, rofi -show drun
          bind = $mainMod, P, exec, rofi-rbw
          bind = $mainMod, E, exec, rofimoji
          bind = $mainMod SHIFT, E, exec, rofi -show emoji
          bind = $mainMod, C, killactive,
          bind = $mainMod SHIFT, Q, exec, swaylock -f -i ~/pictures/lock.jpg
          bind = $mainMod, Q, exec, qutebrowser
          bind = $mainMod SHIFT, F, togglefloating,
          bind = $mainMod, F, fullscreen, 0

          # Move windows
          bind = $mainMod SHIFT, H, swapwindow, l
          bind = $mainMod SHIFT, L, swapwindow, r
          bind = $mainMod SHIFT, K, swapwindow, u
          bind = $mainMod SHIFT, J, swapwindow, d

          # Move focus with mainMod + hjkl
          bind = $mainMod, H, movefocus, l
          bind = $mainMod, L, movefocus, r
          bind = $mainMod, K, movefocus, u
          bind = $mainMod, J, movefocus, d

          # Move focus to anothe monitor
          bind = $mainMod, I, focusmonitor, l
          bind = $mainMod, O, focusmonitor, r

          # Move window to anothe monitor
          bind = $mainMod SHIFT, I, movewindow, mon:l
          bind = $mainMod SHIFT, O, movewindow, mon:r

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow

          # Media keys
          bind = ,XF86AudioRaiseVolume, exec, pw-volume change '+5%'
          bind = ,XF86AudioLowerVolume, exec, pw-volume change '-5%'
          bind = ,XF86AudioMute, exec, pw-volume mute toggle
          '';
        };
      };
    };
  }

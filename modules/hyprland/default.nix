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
    hypr.monitors = mkOption {
      description = "Monitor setup";
      type = types.listOf types.str;
      default = [
        ",preferred,auto,auto"
      ];
    };
    hypr.workspaces = mkOption {
      description = "Workspaces setup";
      type = types.listOf types.str;
      default = [ ];
    };
    hypr.cursor.size = mkOption {
      description = "Cursor size";
      type = types.int;
      default = 32;
    };
    hypr.extraConfig = mkOption {
      description = "Extra config";
      type = types.str;
      default = "";
    };
  };

  # if my-config.template.desktop.gnome.enable is set to true
  # set the following options
  config = mkIf config.my-config.hypr.enable {
    security.pam.services.swaylock = {};

    programs.dconf.enable = true;

    # Enable sound.
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    home-manager.users.ejiek = {
      home.packages = with pkgs; [
        brightnessctl
        grim # take screenshots
        hyprland-per-window-layout
        hyprpaper
        hyprpicker
        notify-desktop
        pulsemixer
        slurp # Select a region in a Wayland compositor | used for screenshots
        swaylock
        swaynotificationcenter
        wireplumber
        wl-clipboard
        xdg-utils
      ];

      home.sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        NIXOS_OZONE_WL = "1";
      };

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
        cursorTheme = {
          package = pkgs.nordzy-cursor-theme;
          name = "Nordzy-cursors";
          size = config.my-config.hypr.cursor.size;
        };
      };

      home.pointerCursor = {
        package = pkgs.nordzy-cursor-theme;
        name = "Nordzy-cursors";
        gtk.enable = true;
        size = config.my-config.hypr.cursor.size;
      };

      home.file = {
        "./.config/electron25-flags.conf".text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
        '';
      };

      home.file = {
        "./.config/electron13-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
        '';
      };

      # TODO: take a look at https://github.com/Duckonaut/split-monitor-workspaces
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland = {
          enable = true;
        };
        systemd.enable = true;
        settings = {
          monitor = config.my-config.hypr.monitors;
          xwayland = {
            force_zero_scaling = true;
          };

          input = {
            kb_layout = "us,ru";
            kb_options = "grp:caps_toggle,grp_led:caps";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              clickfinger_behavior = true;
            };
            sensitivity = 0;
          };
          gestures = {
            workspace_swipe = true;
          };

          workspace = config.my-config.hypr.workspaces;

          general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 2;
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";

            layout = "${config.my-config.hypr.layout}";
          };

          decoration = {
            rounding = 5;
            blur = {
              enabled = "yes";
              size = 3;
              passes = 1;
              new_optimizations = "on";
            };
            drop_shadow = "yes";
            shadow_range = 4;
            shadow_render_power = 3;
            "col.shadow" = "rgba(1a1a1aee)";
          };
          animations = {
            enabled = "yes";
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          dwindle = {
            pseudotile = "yes";
            preserve_split = "yes";
            no_gaps_when_only = true;
          };
          master = {
            new_is_master = false;
            no_gaps_when_only = true;
            orientation = "center";
          };

          "$mainMod" = "SUPER";

          bind = [
            "$mainMod, Return, exec, alacritty"
            "$mainMod, Space, exec, rofi -show drun"
            "$mainMod, P, exec, rofi-rbw"
            "$mainMod, E, exec, rofimoji"
            "$mainMod SHIFT, E, exec, rofi -show emoji"
            "$mainMod SHIFT, C, killactive,"
            "$mainMod SHIFT, Q, exec, swaylock -f -i ~/pictures/lock.jpg"
            "$mainMod, Q, exec, qutebrowser"
            "$mainMod SHIFT, F, togglefloating,"
            "$mainMod, F, fullscreen, 0"

            # Move windows
            "$mainMod SHIFT, H, swapwindow, l"
            "$mainMod SHIFT, L, swapwindow, r"
            "$mainMod SHIFT, K, swapwindow, u"
            "$mainMod SHIFT, J, swapwindow, d"

            # Move focus with mainMod + hjkl
            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            # Move focus to another monitor
            "$mainMod, I, focusmonitor, l"
            "$mainMod, O, focusmonitor, r"

            # Move window to anothe monitor
            "$mainMod SHIFT, I, movewindow, mon:l"
            "$mainMod SHIFT, O, movewindow, mon:r"

            # Switch workspaces with mainMod + [0-9]
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            # Scroll through existing workspaces with mainMod + scroll
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"

            # Media keys
            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ toggle"
            "$mainMod, M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessDown, exec, brightnessctl set '5%-'"
            ",XF86MonBrightnessUp, exec, brightnessctl set '+5%'"

            # Color picker
            "$mainMod ALT, P, exec, hyprpicker --autocopy --no-fancy"

            # Screenshots
            "$mainMod, S, exec, TO_FILE=false FULL_SCREEN=true ~/.config/hypr/screenshot.sh"
            "$mainMod ALT, S, exec, TO_FILE=true FULL_SCREEN=true ~/.config/hypr/screenshot.sh"
            "$mainMod SHIFT, S, exec, TO_FILE=false FULL_SCREEN=false ~/.config/hypr/screenshot.sh"
            "$mainMod SHIFT ALT, S, exec, TO_FILE=true FULL_SCREEN=false ~/.config/hypr/screenshot.sh"

            # Notifications
            "$mainMod, N, exec, swaync-client --toggle-panel"
            "$mainMod, D, exec, swaync-client --toggle-dnd"

          ];

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          exec-once = [
            # Notifications
            "${pkgs.swaynotificationcenter}/bin/swaync"

            # Keyboard layout per window
            "${pkgs.hyprland-per-window-layout}/bin/hyprland-per-window-layout"

            # Wallpaper
            "${pkgs.hyprpaper}/bin/hyprpaper"
          ];
        };
        extraConfig = config.my-config.hypr.extraConfig;
      };

      home.file = {
        "./.config/hypr/hyprpaper.conf".text = ''
        ipc = off
        preload = /home/ejiek/pictures/bg.jpg
        wallpaper = ,contain:/home/ejiek/pictures/bg.jpg
        '';
      };

        #home.activation.screenshotActication = home-manager.dag.entryAfter ["WriteBoundary"] ''
        #  chmod +x ~/.config/hypr/screenshot.sh
        #'';

        home.file = {
          "wl-screenshot" = {
            target = ".config/hypr/screenshot.sh";
            source = ./screenshot.sh;
          };
        };
      };
    };
  }

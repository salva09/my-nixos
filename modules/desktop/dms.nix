{ pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  services.displayManager.gdm.enable = true;

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-stable;

  programs.dankMaterialShell = {
    enable = true;

    greeter = {
      enable = false;
      compositor.name = "niri"; # Or "hyprland" or "sway"
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableBrightnessControl = true; # Backlight/brightness controls
    enableColorPicker = true; # Color picker tool
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableSystemSound = true; # System sound effects
  };

  home-manager.sharedModules = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    (
      { config, pkgs, ... }:
      {
        programs.dankMaterialShell = {
          enable = true;
          niri = {
            enableKeybinds = true;
            enableSpawn = true;
          };
        };

        programs.niri.settings = {
          environment = {
            XDG_CURRENT_DESKTOP = "niri";
            QT_QPA_PLATFORM = "wayland";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";

            # Force Qt apps to look like GTK apps
            QT_QPA_PLATFORMTHEME = "gtk3";
            QT_QPA_PLATFORMTHEME_QT6 = "gtk3";

            # Useful addition for Java apps in Niri
            _JAVA_AWT_WM_NONREPARENTING = "1";
          };

          layout = {
            gaps = 5;
            background-color = "Transparent";
          };

          layer-rules = [
            {
              matches = [ { namespace = "dms:blurwallpaper"; } ];
              place-within-backdrop = true;
            }
          ];

          window-rules = [
            # 1. GNOME Apps: Rounded corners, no border background
            {
              matches = [
                # In Nix strings, we must double-escape backslashes for Regex: \\.
                { app-id = "^org\\.gnome\\."; }
              ];
              draw-border-with-background = false;
              geometry-corner-radius = {
                bottom-left = 12.0;
                bottom-right = 12.0;
                top-left = 12.0;
                top-right = 12.0;
              };
              clip-to-geometry = true;
            }

            # 2. Terminals: No border background
            # I converted your multiple matches into one REGEX, because Niri 'match'
            # acts as AND, but you want OR.
            {
              matches = [
                { app-id = "^(org\\.wezfurlong\\.wezterm|Alacritty|zen|com\\.mitchellh\\.ghostty|kitty)$"; }
              ];
              draw-border-with-background = false;
            }

            # 3. Inactive Windows: Opacity
            {
              matches = [ { is-active = false; } ];
              opacity = 0.9;
            }

            # 4. Global Defaults (No match = applies to everything)
            {
              geometry-corner-radius = {
                bottom-left = 12.0;
                bottom-right = 12.0;
                top-left = 12.0;
                top-right = 12.0;
              };
              clip-to-geometry = true;
            }

            # 5. Dank Material Shell / Quickshell: Float by default
            {
              matches = [ { app-id = "org\\.quickshell$"; } ];
              open-floating = true;
            }
          ];

          binds = {
            "Mod+T".action.spawn = "ghostty";
            "Mod+Q".action.close-window = [ ];
            "Mod+Shift+E".action.quit.skip-confirmation = true;
          };

          input.keyboard.xkb.layout = "us";

          hotkey-overlay.skip-at-startup = true;

          cursor.theme = "Adwaita";
        };

        gtk = {
          enable = true;
          theme = {
            name = "adw-gtk3";
            package = pkgs.adw-gtk3;
          };
          cursorTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
          };
          font = {
            name = "Adwaita";
            package = pkgs.adwaita-fonts;
          };
        };
      }
    )
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  services.gnome.core-apps.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music
    gnome-software
    geary
    gnome-console
  ];

  environment.systemPackages = with pkgs; [
    ghostty
  ];

  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}

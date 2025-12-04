{ pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  services.displayManager.gdm.enable = true;

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  home-manager.sharedModules = [
    inputs.noctalia.homeModules.default
    (
      { ... }:
      {
        programs.noctalia-shell = {
          enable = true;
        };

        programs.niri.settings = {
          spawn-at-startup = [
            {
              command = [ "noctalia-shell" ];
            }
          ];

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
            "Mod+Space".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
            "Mod+T".action.spawn = "ghostty";
            "Mod+Q".action.close-window = [ ];
            "Mod+Shift+E".action.quit.skip-confirmation = true;
          };

          input.keyboard.xkb.layout = "us";

          hotkey-overlay.skip-at-startup = true;

          cursor.theme = "Adwaita";
        };
      }
    )
  ];
}

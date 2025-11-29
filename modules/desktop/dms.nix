{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  services.displayManager.gdm.enable = true;

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  programs.dankMaterialShell = {
    enable = true;

    greeter = {
      enable = false;
      compositor.name = "niri";  # Or "hyprland" or "sway"
    };

    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableClipboard = true;            # Clipboard history manager
    enableVPN = true;                  # VPN management widget
    enableBrightnessControl = true;    # Backlight/brightness controls
    enableColorPicker = true;          # Color picker tool
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableSystemSound = true;          # System sound effects
  };

  home-manager.sharedModules = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    ({ config, pkgs, ... }: {
      programs.dankMaterialShell = {
        enable = true;
        niri = {
          # enableKeybinds = true;
          enableSpawn = true;
        };
      };

      programs.niri.settings = {
        binds = {
          "Mod+Shift+E".action.quit.skip-confirmation = true;
        };

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
    })
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
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}

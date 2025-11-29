{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
    inputs.dankMaterialShell.nixosModules.greeter
  ];
  
  home-manager.sharedModules = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  services.displayManager.gdm.enable = true;

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-stable;

  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
    };

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

  services.gnome.core-apps.enable = true;

  systemd.user.services.niri-flake-polkit.enable = false;
}

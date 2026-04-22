{ pkgs, inputs, ... }:

{
  services.displayManager.dms-greeter = {
    enable = true;
    configHome = "/home/salva";
    compositor.name = "niri";
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;

  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
  };

  programs.dsearch = {
    enable = true;

    package = inputs.danksearch.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true; # Enable systemd user service
      target = "default.target"; # Start with user session
    };
  };

  programs.kdeconnect.enable = true;

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
  };

  # services.gnome.gnome-keyring.enable = true;
  services.gnome.core-apps.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music
    gnome-software
    geary
  ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    adw-gtk3
    qt6Packages.qt6ct
    adwaita-icon-theme

    ghostty
    bazaar
    mission-center
  ];

  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}

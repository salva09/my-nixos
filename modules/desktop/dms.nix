{ pkgs, ... }:

{
  services.displayManager.dms-greeter = {
    enable = true;
    configHome = "/home/salva";
    compositor.name = "niri";
  };

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  programs.niri.enable = true;

  programs.dms-shell = {
    enable = true;

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
    (
      { pkgs, ... }:
      {
        gtk = {
          enable = true;

          cursorTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
          };

          font = {
            name = "Adwaita Sans";
            size = 11;
            package = pkgs.adwaita-fonts;
          };

          iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
          };

          gtk3 = {
            enable = true;

            theme = {
              name = "adw-gtk3";
              package = pkgs.adw-gtk3;
            };
          };
        };
      }
    )
  ];

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
  ];

  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}

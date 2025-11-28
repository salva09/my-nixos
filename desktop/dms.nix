{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
    #inputs.dankMaterialShell.nixosModules.dankMaterialShell.niri
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;

  programs.niri.enable = true;
  
  programs.dankMaterialShell = {
    enable = true;
    
    #niri = {
    #  enableKeybinds = true;   # Automatic keybinding configuration
      #enableSpawn = true;      # Auto-start DMS with niri
    #};
    
    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
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
  
  #programs.dankMaterialShell.greeter = {
    #enable = true;
    #compositor.name = "niri";  # Or "hyprland" or "sway"
    # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
    #configHome = "/home/salva";

    # Custom config files for non-standard config locations
    #configFiles = [
    #  "/home/salva/.config/DankMaterialShell/settings.json"
    #];
  #};
  
  services.displayManager.gdm.enable = true;

  systemd.user.services.niri-flake-polkit.enable = false;
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gnome"
        ];
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };
  };
  
  services.gnome.core-apps.enable = true;
  
  environment.variables = {
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
  };
  
  environment.systemPackages = [
    pkgs.adw-gtk3
    pkgs.gnome-tweaks
    pkgs.papirus-icon-theme
    pkgs.adwaita-icon-theme
  ];
  
  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}

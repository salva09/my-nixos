{
  pkgs,
  lib,
  ...
}:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-developer-tools.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music
    gnome-software
    geary
    gnome-system-monitor
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.adwaita-mono
  ];

  environment.systemPackages = with pkgs; [
    file-roller
    mission-center

    # Gnome extensions
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.dash-to-dock
  ];

  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      {
        dconf = {
          enable = true;

          settings = {
            "org/gnome/mutter" = {
              experimental-features = [
                "scale-monitor-framebuffer"
                "variable-refresh-rate"
                # "xwayland-native-scaling"
              ];
              check-alive-timeout = lib.gvariant.mkUint32 10000;
            };
            "org/gnome/gnome-session" = {
              logout-prompt = false;
            };
            "org/gnome/desktop/interface" = {
              font-antialiasing = "grayscale";
              font-hinting = "none";
              document-font-name = "Adwaita Sans 11";
              monospace-font-name = "Adwaita Mono 11";
            };
            "org/gnome/desktop/wm/preferences" = {
              button-layout = ":close";
            };
          };
        };

        gtk = {
          enable = true;

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

        qt = {
          enable = true;
          platformTheme.name = "gtk3";
        };

        home.pointerCursor = {
          enable = true;
          name = "Adwaita";
          size = 24;
          package = pkgs.adwaita-icon-theme;
        };
      }
    )
  ];
}

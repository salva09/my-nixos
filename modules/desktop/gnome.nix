{
  pkgs,
  lib,
  ...
}:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music
    gnome-software
    geary
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
    gnomeExtensions.grand-theft-focus
    gnomeExtensions.advanced-alttab-window-switcher
  ];

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        "org/gnome/mutter" = {
          experimental-features = [
            # "scale-monitor-framebuffer"
            # "variable-refresh-rate"
            # "xwayland-native-scaling"
          ];
          check-alive-timeout = lib.gvariant.mkUint32 10000;
        };
        "org/gnome/gnome-session" = {
          logout-prompt = false;
        };
      };
    }
  ];

  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      {
        gtk = {
          enable = true;

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

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.adwaita-mono
  ];
}

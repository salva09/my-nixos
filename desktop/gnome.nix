{ config, pkgs, ... }:

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
    gnomeExtensions.gsconnect
    gnomeExtensions.grand-theft-focus
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.tiling-shell
  ];
}

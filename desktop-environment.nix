{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-tour
    gnome-software
    geary
    gnome-music
  ];
  
  environment.systemPackages = with pkgs; [
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.grand-theft-focus
    gnomeExtensions.advanced-alttab-window-switcher
  ];
}

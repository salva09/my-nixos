{
  pkgs,
  ...
}:

{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.system76-scheduler.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  services.gnome.gcr-ssh-agent.enable = false;
  services.gnome.core-apps.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music
    gnome-software
    geary
    gnome-console
    gnome-system-monitor
  ];

  environment.systemPackages = with pkgs; [
    file-roller
    mission-center
    loupe
    papers
    ghostty
    adw-gtk3
  ];
}

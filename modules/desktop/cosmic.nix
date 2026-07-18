{
  pkgs,
  ...
}:

{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.system76-scheduler.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  environment.systemPackages = with pkgs; [
    adw-gtk3

    file-roller
    mission-center
    ghostty
    gnome-calculator
    loupe
    baobab
    nautilus
  ];

  services.gnome.gcr-ssh-agent.enable = false;
  programs.gnome-disks.enable = true;

  fonts.packages = [
    pkgs.rubik
  ];
}

{
  pkgs,
  ...
}:

{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.system76-scheduler.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  fonts.packages = with pkgs; [
    nerd-fonts.adwaita-mono
  ];

  environment.systemPackages = with pkgs; [
    file-roller
    mission-center
  ];
}

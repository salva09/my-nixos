{
  pkgs,
  ...
}:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.gcr-ssh-agent.enable = false;
  services.gnome.core-developer-tools.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-software
    gnome-system-monitor
    gnome-console
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  environment.systemPackages = with pkgs; [
    file-roller
    mission-center
    ghostty
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {
      gnome = [
        "ghostty.desktop"
      ];
    };
  };
}

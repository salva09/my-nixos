{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Critical for Steam/Wine (even via Flatpak)
  };

  hardware.steam-hardware.enable = true;

  services.udev.packages = [
    pkgs.game-devices-udev-rules
  ];

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = false;

    package = pkgs.steam.override {
      extraArgs = "-steamos3";
    };
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;

    settings = {
      general = {
        reaper_freq = 5;
        desiredgov = "performance";
        igpu_desiredgov = "performance";
        softrealtime = "auto";
        renice = 10;
        inhibit_screensaver = 1;
      };
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true; # Allow it to prioritize itself
  };

  services.lact.enable = false;

  environment.systemPackages = with pkgs; [
    r2modman
    lumafly
    mangohud
  ];
}

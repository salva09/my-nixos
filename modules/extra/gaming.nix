{ ... }:

{
  programs.steam = {
    enable = true;
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
}

{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    
    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    consoleLogLevel = 0;
    
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };
}

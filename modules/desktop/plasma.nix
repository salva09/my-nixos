{ config, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  services.displayManager.autoLogin.enable  = true;
  services.displayManager.autoLogin.user = "salva";
}

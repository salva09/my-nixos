{ ... }:

{
  imports = [
    ./hardware.nix # Hardware Config
    ../../modules/core/default.nix # Core System Modules
    ../../modules/desktop/default.nix # Core Desktop Modules
    ../../modules/desktop/cosmic.nix # Desktop Environment

    # Optional modules
    ../../modules/extra/peripherals.nix
    ../../modules/extra/virtualisation.nix
    ../../modules/extra/gaming.nix
  ];

  networking.hostName = "salvas-desktop";

  services.displayManager = {
    autoLogin = {
      enable = false;
      user = "salva";
    };
    defaultSession = "cosmic";
  };
}

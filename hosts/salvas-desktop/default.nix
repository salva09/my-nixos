{ ... }:

{
  imports = [
    ./hardware.nix # Hardware Config
    ../../modules/core/default.nix # Core System Modules
    ../../modules/desktop/default.nix # Core Desktop Modules
    ../../modules/desktop/cosmic.nix # Desktop Environment

    # Optional modules
    ../../modules/extra/peripherals.nix
    ../../modules/extra/gaming.nix
    ../../modules/extra/overlays.nix
  ];

  networking.hostName = "salvas-desktop";

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "salva";
    };
    defaultSession = "cosmic";
  };
}

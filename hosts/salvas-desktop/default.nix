{ ... }:

{
  imports = [
    ./hardware.nix # Hardware Config
    ../../modules/core/default.nix # Core System Modules
    ../../modules/desktop/default.nix # Core Desktop Modules
    ../../modules/desktop/cosmic.nix # Desktop Environment
    ../../users/salva.nix # User Config

    # Optional modules
    ../../modules/extra/flatpak.nix
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

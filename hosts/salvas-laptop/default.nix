{ config, ... }:

{
  imports = [
    ./hardware.nix # Hardware Config
    ../../modules/core/default.nix # Core System Modules
    ../../modules/desktop/default.nix # Core Desktop Modules
    ../../modules/desktop/plasma.nix # Desktop Environment

    ../../modules/extra/postgres.nix
    ../../modules/extra/gaming.nix
  ];

  networking.hostName = "salvas-laptop";
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    # 1. Hardware Config (Relative path)
    ./hardware.nix

    # 2. Core System Modules (Path to root)
    ../../modules/core/boot.nix
    ../../modules/core/system.nix   # Was your old root default.nix
    ../../modules/core/flatpak.nix

    # 3. Desktop Environment
    ../../modules/desktop/gnome.nix
    # ../../modules/desktop/noctalia.nix # Easy to toggle here!

    # 4. User Config
    ../../users/hm-defaults.nix     # Was user/home.nix
    ../../users/salva.nix
  ];

  networking.hostName = "salvas-desktop";

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "salva";
}

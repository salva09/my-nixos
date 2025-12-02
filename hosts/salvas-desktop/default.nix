{ ... }:

{
  imports = [
    # 1. Hardware Config (Relative path)
    ./hardware.nix

    # 2. Core System Modules (Path to root)
    ../../modules/core/boot.nix
    ../../modules/core/system.nix
    ../../modules/core/flatpak.nix

    ../../modules/gaming.nix

    # 3. Desktop Environment
    ../../modules/desktop/gnome.nix

    # 4. User Config
    ../../users/hm-defaults.nix
    ../../users/salva.nix
  ];

  networking.hostName = "salvas-desktop";

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "salva";
}

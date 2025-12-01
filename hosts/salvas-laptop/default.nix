{ ... }:

{
  imports = [
    # 1. Hardware Config (Relative path)
    ./hardware.nix

    # 2. Core System Modules (Path to root)
    ../../modules/core/boot.nix
    ../../modules/core/system.nix
    ../../modules/core/flatpak.nix

    # 3. Desktop Environment
    #../../modules/desktop/plasma.nix
    ../../modules/desktop/dms.nix

    # 4. User Config
    ../../users/hm-defaults.nix
    ../../users/salva.nix
  ];

  networking.hostName = "salvas-laptop";

  # Any desktop-specific overrides can go here
  # e.g. Specific monitor config, extra packages just for this PC
}

{ ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/core/boot.nix
    ../../modules/core/system.nix
    ../../modules/core/flatpak.nix

    ../../modules/desktop/gnome.nix

    ../../users/hm-defaults.nix
    ../../users/salva.nix
  ];

  networking.hostName = "salvas-laptop";
}

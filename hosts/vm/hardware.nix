{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # We need a root filesystem defined for the build to succeed,
  # even though build-vm overrides this with its own disk image.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  # Use the systemd-boot loader (generic)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Standard platform setting
  nixpkgs.hostPlatform = "x86_64-linux";
}

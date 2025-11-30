{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "kvm-amd" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/47aab21e-761c-4c95-b852-823ba50a93c1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5311-F2AA";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/8c47ea35-550b-47af-8b51-11007fa79e8a";
    fsType = "ext4";
    options = [ "defaults" "nofail" "noatime" "x-gvfs-show" ];
  };

  fileSystems."/home/salva/Downloads" = { device = "/mnt/data/Downloads"; options = [ "bind" "nofail" "x-gvfs-hide" ]; };
  fileSystems."/home/salva/Documents" = { device = "/mnt/data/Documents"; options = [ "bind" "nofail" "x-gvfs-hide" ]; };
  fileSystems."/home/salva/Music"     = { device = "/mnt/data/Music";     options = [ "bind" "nofail" "x-gvfs-hide" ]; };
  fileSystems."/home/salva/Pictures"  = { device = "/mnt/data/Pictures";  options = [ "bind" "nofail" "x-gvfs-hide" ]; };
  fileSystems."/home/salva/Videos"    = { device = "/mnt/data/Videos";    options = [ "bind" "nofail" "x-gvfs-hide" ]; };
  fileSystems."/home/salva/Games"     = { device = "/mnt/data/Games";     options = [ "bind" "nofail" "x-gvfs-hide" ]; };

  zramSwap.enable = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

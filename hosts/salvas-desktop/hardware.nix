{
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # 1. The Root Subvolume (@)
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7efc6d6e-5e01-46f9-873d-f96322b1e429";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B8B6-AD50";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/8c47ea35-550b-47af-8b51-11007fa79e8a";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "noatime"
    ];
  };

  zramSwap.enable = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.amdgpu.overdrive.enable = false;
  hardware.amdgpu.initrd.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}

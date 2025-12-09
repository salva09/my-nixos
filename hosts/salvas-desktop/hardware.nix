{
  config,
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
    device = "/dev/disk/by-uuid/284e44a0-103e-464b-957f-fb6495fc581d";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
      "noatime"
    ];
  };

  # 2. The Home Subvolume (@home)
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/284e44a0-103e-464b-957f-fb6495fc581d";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
    ];
  };

  # 3. The Nix Store Subvolume (@nix)
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/284e44a0-103e-464b-957f-fb6495fc581d";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C0FB-B396";
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
  hardware.amdgpu.overdrive.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

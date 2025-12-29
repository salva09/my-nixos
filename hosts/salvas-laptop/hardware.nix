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

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/70cd15fd-453f-42f1-8f88-489cdd5d9200";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
      "noatime"
      "discard=async"
    ];
  };
  
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/70cd15fd-453f-42f1-8f88-489cdd5d9200";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd"
      "noatime"
      "discard=async"
    ];
  };
  
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/70cd15fd-453f-42f1-8f88-489cdd5d9200";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
      "discard=async"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C4C6-6D85";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
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

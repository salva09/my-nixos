{ config, pkgs, inputs, ... }:

{
  imports = [
    # 1. Hardware Config (Relative path)
    ./hardware.nix

    # 2. Core System Modules (Path to root)
    ../../modules/core/boot.nix
    ../../modules/core/system.nix

    # 3. Desktop Environment
    #../../modules/desktop/plasma.nix
    ../../modules/desktop/dms.nix # Easy to toggle here!

    # 4. User Config
    ../../users/hm-defaults.nix     # Was user/home.nix
    ../../users/guest.nix
  ];

  networking.hostName = "vm";

  # This config ONLY applies when you use 'build-vm'
  virtualisation.vmVariant = {
    # 1. Give it more RAM and Cores
    virtualisation = {
      memorySize = 4096; # 4GB RAM
      cores = 4;         # 4 CPU Cores
      graphics = true;   # Ensure it has a screen
    };

    # 2. Fix Resolution (Optional)
    # VMs often default to 800x600. This helps force a larger window.
    virtualisation.qemu.options = [
      "-vga virtio"
      "-display gtk,gl=on" # Use GTK with OpenGL acceleration
    ];
  };
}

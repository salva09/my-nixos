{ ... }:

{
  imports = [
    ./hardware.nix # Hardware Config
    ../../modules/core/default.nix # Core System Modules
    ../../modules/desktop/default.nix # Core Desktop Modules
    ../../modules/desktop/cosmic.nix # Desktop Environment

    # Optional modules
    ../../modules/extra/flatpak.nix
    #../../modules/extra/gaming.nix
    #../../modules/extra/virtualisation.nix
  ];

  networking.hostName = "vm";

  # This config ONLY applies when you use 'build-vm'
  virtualisation.vmVariant = {
    # 1. Give it more RAM and Cores
    virtualisation = {
      diskSize = 8192;
      memorySize = 4096; # 4GB RAM
      cores = 4; # 4 CPU Cores
      graphics = true; # Ensure it has a screen
    };

    # 2. Fix Resolution (Optional)
    # VMs often default to 800x600. This helps force a larger window.
    virtualisation.qemu.options = [
      "-vga virtio"
      "-display gtk,gl=on" # Use GTK with OpenGL acceleration
    ];
  };
}

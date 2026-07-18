{
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../modules/core/default.nix
    ../../modules/desktop/default.nix
    ../../modules/desktop/cosmic.nix
  ];

  networking.hostName = "vm";

  # This config ONLY applies when you use 'build-vm'
  virtualisation.vmVariant = {
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
      "-device virtio-gpu-gl"
      "-display gtk,gl=on" # Use GTK with OpenGL acceleration
    ];
  };
}

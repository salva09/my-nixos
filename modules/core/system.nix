{ pkgs, ... }:

{
  nix = {
    package = pkgs.lix;

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  services.userborn.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Monterrey";
  i18n.defaultLocale = "en_US.UTF-8";

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.libinput.enable = true;

  hardware.uinput.enable = true;
  services.udev.extraRules = ''
    # Keychron M6 Mouse (USB)
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0666", GROUP="users"

    # Keychron M6 Mouse (2.4GHz Dongle)
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0360", MODE="0666", GROUP="users"
  '';

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  documentation.nixos.enable = false;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    git
    distrobox
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  networking.firewall = {
    enable = true;

    backend = "firewalld";

    allowedTCPPorts = [
      53317 # Localsend
    ];

    allowedUDPPorts = [
      53317 # Localsend
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

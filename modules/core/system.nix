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
      use-xdg-base-directories = true;
    };
  };

  # Experimental features
  system.nixos-init.enable = false; # Causes issues with distrobox
  services.userborn.enable = false; # Causes issues with distrobox

  system.etc.overlay.enable = true;

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.udev.extraRules = ''
    # Keychron M6 Mouse (USB)
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0666", GROUP="users"

    # Keychron M6 Mouse (2.4GHz Dongle)
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0360", MODE="0666", GROUP="users"
  '';

  documentation.nixos.enable = false;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

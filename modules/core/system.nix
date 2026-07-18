{ pkgs, ... }:

{
  nix = {
    settings = {
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      max-jobs = 1;
      cores = 8;

      trusted-users = [
        "root"
        "salva"
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Experimental features
  system.nixos-init.enable = true; # Causes issues with distrobox
  services.userborn.enable = true; # Causes issues with distrobox

  system.etc.overlay.enable = true;

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_US.UTF-8";

  documentation.nixos.enable = false;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.hidapi
      pkgs.udev
      pkgs.icu
      pkgs.gsettings-desktop-schemas
      pkgs.gtk3
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    stdenv.cc.cc.lib
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/salva/Projects/my-nixos";
  };

  environment.systemPackages = with pkgs; [
    git # Requeried by nh to work
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

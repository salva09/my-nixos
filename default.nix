# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  
  networking.networkmanager.enable = true;

  time.timeZone = "America/Monterrey";

  i18n.defaultLocale = "en_US.UTF-8";
  
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  
  programs.gamemode.enable = true;
  
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];
  
  hardware.uinput.enable = true;

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  documentation.nixos.enable = false;
  
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];
  
  networking.firewall.allowedTCPPorts = [
    # Localsend port
    53317
  ];
  networking.firewall.allowedUDPPorts = [
    # Localsend port
    53317
  ];
  networking.firewall.enable = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

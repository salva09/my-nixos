{ pkgs, ... }:

{
  networking.networkmanager.enable = true;

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

  services.avahi = {
    enable = true;
    openFirewall = true;

    publish = {
      enable = true;
      userServices = true;
    };
  };
}

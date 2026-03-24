{ ... }:

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

  programs.steam = {
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}

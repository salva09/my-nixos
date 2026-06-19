{ ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.useNetworkd = true;

  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      53317 # Localsend
      25565 # Minecraft
    ];

    allowedTCPPortRanges = [
      {
        from = 1024;
        to = 65535;
      }
    ];

    allowedUDPPorts = [
      53317 # Localsend
      44453 # Minecraft
      4445
      1900
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

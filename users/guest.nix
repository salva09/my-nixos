{ ... }:

{
  users.users.guest = {
    isNormalUser = true;
    description = "Guest User";
    extraGroups = [
      "networkmanager"
      "video"
      "audio"
    ];
    initialPassword = "guest";
  };

  home-manager.users.guest =
    { pkgs, ... }:
    {
      home.stateVersion = "25.11";

      programs.bash.enable = true;
    };
}

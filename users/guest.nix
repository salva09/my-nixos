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
}

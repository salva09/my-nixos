{
  config,
  pkgs,
  lib,
  ...
}:

let
  username = "salva";
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Salva";
    hashedPassword = "$y$j9T$6OkXEdC.0DHcfOHn7gouE1$8xxgexZ8DsZaQyT6knFQhPZXWH654ltVEIq.dKIo8W7";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "i2c"
    ];
    autoSubUidGidRange = true;
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';

    loginShellInit = ''
      export SSH_AUTH_SOCK=/home/salva/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock
    '';
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.tide
  ];

  programs.fish.enable = true;
}

{
  config,
  pkgs,
  lib,
  ...
}:

let
  isDesktop = config.networking.hostName == "salvas-desktop";
in
{
  programs.fish.enable = true;

  users.users.salva = {
    isNormalUser = true;
    description = "Salva";

    shell = pkgs.fish;

    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
  };

  home-manager.users.salva =
    { pkgs, config, ... }:

    {
      home.packages = with pkgs; [
        zed-editor
        nixd
      ];

      home.sessionVariables = {
        SSH_AUTH_SOCK = "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';

        shellAliases = {
          conf = "cd $HOME/Documents/my-nixos"; # Quick jump to config
          update-conf = "run0 nixos-rebuild switch --flake $HOME/Documents/my-nixos";
        };

        plugins = [
          {
            name = "tide";
            src = pkgs.fishPlugins.tide.src;
          }
        ];
      };

      programs.git = {
        enable = true;

        settings = {
          user.name = "Salva HG";
          user.email = "salva.hg01@gmail.com";

          init.defaultBranch = "main";
          pull.rebase = false;
        };
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = false;
      };

      home.file = lib.mkMerge [
        (lib.mkIf isDesktop
          {
            "Downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Downloads";
            "Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Documents";
            "Music".source     = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Music";
            "Pictures".source  = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Pictures";
            "Videos".source    = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Videos";
            "Games".source     = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Games";

            ".var/app/app.zen_browser.zen".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/.var/app/app.zen_browser.zen";
            ".var/app/com.rtosta.zapzap".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/.var/app/com.rtosta.zapzap";
            ".var/app/org.mozilla.Thunderbird".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/.var/app/org.mozilla.Thunderbird";

            ".local/share/PrismLauncher".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Games/PrismLauncher";
          }
        )
      ];

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "25.11";
    };
}

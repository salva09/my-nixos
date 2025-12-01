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
    let
      flatpakApps = [
        "app.zen_browser.zen"
        "com.discordapp.Discord"
        "com.rtosta.zapzap"
        "org.mozilla.Thunderbird"
        "org.prismlauncher.PrismLauncher"
      ];

      linkFlatpak = app: {
        name = ".var/app/${app}";
        value = {
          source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/.var/app/${app}";
        };
      };
    in
    {
      home.packages = with pkgs; [
        zed-editor
        nil
      ];

      home.sessionVariables = {
        SSH_AUTH_SOCK = "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock";
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
        createDirectories = true;
      };

      home.file = lib.mkMerge [
        (lib.mkIf isDesktop (builtins.listToAttrs (map linkFlatpak flatpakApps)))

        # Block B: Logic for LAPTOP (Optional)
        # If you wanted specific laptop files, you could add:
        # (lib.mkIf (!isDesktop) { ... })
      ];

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "25.11";
    };
}

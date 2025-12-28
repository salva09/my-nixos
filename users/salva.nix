{
  config,
  pkgs,
  lib,
  ...
}:

let
  username = "salva";
  isDesktop = config.networking.hostName == "salvas-desktop";

  # Directories to link from /mnt/data to /home/salva
  userDirs = [
    "Documents"
    "Music"
    "Pictures"
    "Videos"
    "Games"
    "Downloads"
  ];
in
{
  programs.fish.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "Salva";
    hashedPassword = "$y$j9T$6OkXEdC.0DHcfOHn7gouE1$8xxgexZ8DsZaQyT6knFQhPZXWH654ltVEIq.dKIo8W7";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
    autoSubUidGidRange = true;
  };

  # 1. Ensure the mount point exists and has the right permissions
  # (Put this in your main configuration.nix or here if this file is always active)
  systemd.tmpfiles.rules = lib.mkIf isDesktop [
    "d /mnt/data 0755 ${username} users -"
  ];

  # 2. Replace Bind Mounts with Symlinks
  system.userActivationScripts.linkSecondaryDrive = lib.mkIf isDesktop {
    text = ''
      # Ensure the source directories exist on the HDD
      for dir in ${builtins.concatStringsSep " " userDirs}; do
        mkdir -p /mnt/data/$dir
      done

      # Create the symlinks in the home directory
      for dir in ${builtins.concatStringsSep " " userDirs}; do
        target="/home/${username}/$dir"
        source="/mnt/data/$dir"

        # Remove existing empty directories or old links to prevent conflicts
        if [ -d "$target" ] && [ ! -L "$target" ]; then
          rmdir "$target" 2>/dev/null || echo "Warning: $target is not empty, skipping link."
        fi

        # Create link if it doesn't exist
        if [ ! -e "$target" ]; then
          ln -s "$source" "$target"
          chown -h ${username}:users "$target"
        fi
      done
    '';
  };

  fileSystems = lib.mkIf isDesktop {
    "/home/salva/.var" = {
      device = "/mnt/data/.var";
      options = [
        "bind"
        "nofail"
        "x-gvfs-hide"
      ];
    };
  };

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      home.stateVersion = "25.11";
      home.preferXdgDirectories = true;

      home.packages = with pkgs; [
        zed-editor
        nixd
        nil
      ];

      home.sessionVariables = {
        NH_OS_FLAKE = "$HOME/Documents/my-nixos";
        SSH_AUTH_SOCK = "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = "set fish_greeting";
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
    };
}

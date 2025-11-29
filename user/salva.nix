{ config, pkgs, ... }:

{
  users.users.salva = {
    isNormalUser = true;
    description = "Salva";
    
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "gamemode"
    ];
  };
  
  home-manager.users.salva = { pkgs, config, ... }:
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
      value = { source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/.var/app/${app}"; };
    };
  in
  {
    home.packages = with pkgs; [
      git
      nerd-fonts.adwaita-mono
    ];
    
    fonts.fontconfig.enable = true;
    
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
        { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      ];
    };
    
    programs.bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    
    programs.git = {
      enable = true;
      
      settings = {
        user.name  = "Salva HG";
        user.email = "salva.hg01@gmail.com";

        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
    
    xdg.userDirs = {
      enable = true;
      createDirectories = false;
    };
    
    home.file = {
      "Downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Downloads";
      "Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Documents";
      "Music".source     = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Music";
      "Pictures".source  = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Pictures";
      "Videos".source    = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Videos";
      "Games".source     = config.lib.file.mkOutOfStoreSymlink "/mnt/data/Games";
    } // builtins.listToAttrs (map linkFlatpak flatpakApps);
    
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.11";
  };
}

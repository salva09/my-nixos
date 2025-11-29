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
  
  home-manager.users.salva = { pkgs, ... }: {
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
        # You can find plugins in nixpkgs, usually named 'fishPlugins.<name>'
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
      
      # CORRECT SYNTAX:
      userName  = "Salva HG";
      userEmail = "salva.hg01@gmail.com";
      
      # For other settings (like default branch, diff tools, etc.)
      # use 'extraConfig'
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
    
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.11";
  };
}

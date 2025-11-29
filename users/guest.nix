{ config, pkgs, ... }:

{
  # 1. NixOS User Configuration
  users.users.guest = {
    isNormalUser = true;
    description = "Guest User";
    
    # Minimal permissions (No 'wheel' group means no sudo!)
    extraGroups = [ "networkmanager" "video" "audio" ];
    
    # Sets the password to "guest"
    # Note: NixOS might ask you to change it on first login, 
    # or you can simply use this for testing.
    initialPassword = "guest"; 
  };

  # 2. Home Manager Configuration (Minimal)
  home-manager.users.guest = { pkgs, ... }: {
    # We need a state version here too
    home.stateVersion = "25.11";

    # Enable a shell so they can type commands
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}

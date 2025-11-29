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

  home-manager.users.guest = { pkgs, ... }: {
    home.stateVersion = "25.11";

    programs.bash.enable = true;
    gtk.enable = true;
  };
}

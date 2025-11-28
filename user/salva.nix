{ config, pkgs, ... }:

{
  programs.fish.enable = true;
  
  users.users.salva = {
    isNormalUser = true;
    description = "Salva HG";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };
}

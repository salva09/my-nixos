{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };
  
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      salvas-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hardware/salvas-desktop.nix
          ./boot.nix
          ./default.nix
          ./desktop/gnome.nix
          ./user/salva.nix
          ./flatpak.nix
        ];
      };
      
      salvas-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/salvas-laptop.nix
          ./boot.nix
          ./default.nix
          ./desktop/plasma.nix
          ./user/salva.nix
        ];
      };
    };
  };
}

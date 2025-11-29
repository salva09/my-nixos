{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          ./user/home.nix
          ./user/salva.nix
          ./desktop/gnome.nix
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

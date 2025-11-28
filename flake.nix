{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      salvas-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hardware/salvas-desktop.nix
          ./boot.nix
          ./default.nix
          ./desktop/gnome.nix
          ./user/salva.nix
        ];
      };
      
      salvas-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./default.nix
          ./boot.nix
          ./hardware/salvas-desktop.nix
          ./desktop/gnome.nix
          ./user/salva.nix
        ];
      };
    };
  };
}

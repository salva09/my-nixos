{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, ... }: {
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
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware/salvas-laptop.nix
          ./boot.nix
          ./default.nix
          ./desktop/dms.nix
          ./user/salva.nix
        ];
      };
    };
  };
}

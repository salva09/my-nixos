{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ... other inputs (noctalia, niri, etc) ...
  };
  
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      
      # Desktop Host
      salvas-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/salvas-desktop/default.nix ];
      };
      
      # Laptop Host
      salvas-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/salvas-laptop/default.nix ];
      };
      
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/vm/default.nix ];
      };
      
    };
  };
}

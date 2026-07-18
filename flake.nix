{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-test.url = "git+file:///home/salva/Projects/nixpkgs?ref=cosmic-oo7-migration";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-test,
      ...
    }:
    {
      nixosConfigurations = {
        salvas-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/salvas-desktop ];
        };

        salvas-laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/salvas-laptop ];
        };

        vm = nixpkgs-test.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/vm ];
        };
      };
    };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };
  
  outputs = { self, nixpkgs }: {
    nixosConfigurations.salvas-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix
        ./hardware-configuration.nix
        ./boot-configuration.nix
        ./desktop-environment.nix
      ];
    };
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    cachyos.url = "github:xddxdd/nix-cachyos-kernel";
    niri.url = "github:sodiboo/niri-flake";
    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    danksearch.url = "github:AvengeMedia/danksearch";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    {
      nixosConfigurations = {

        # Desktop Host
        salvas-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/salvas-desktop ];
        };

        # Laptop Host
        salvas-laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/salvas-laptop ];
        };

        # Your VM Host
        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/vm ];
        };

      };
    };
}

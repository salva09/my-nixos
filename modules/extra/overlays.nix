{
  ...
}:
{
  nixpkgs.overlays = [
    (
      # Latest COSMIC packages from salva09/nixpkgs
      final: prev:
      let
        src = prev.fetchFromGitHub {
          owner = "salva09";
          repo = "nixpkgs";
          rev = "c5e51a48f2a29251249af5d721dbc2a3c7866538";
          hash = "sha256-lYw4HWV0fgwcSnYLrFa+TAf4J7doIHgMR9tP+z2z4mY=";
        };

        byName = name: "${src}/pkgs/by-name/${builtins.substring 0 2 name}/${name}/package.nix";

        pkgNames = [
          "cosmic-applets"
          "cosmic-applibrary"
          "cosmic-bg"
          "cosmic-comp"
          "cosmic-edit"
          "cosmic-files"
          "cosmic-greeter"
          "cosmic-icons"
          "cosmic-idle"
          "cosmic-initial-setup"
          "cosmic-launcher"
          "cosmic-notifications"
          "cosmic-osd"
          "cosmic-panel"
          "cosmic-player"
          "cosmic-randr"
          "cosmic-screenshot"
          "cosmic-session"
          "cosmic-settings"
          "cosmic-settings-daemon"
          "cosmic-store"
          "cosmic-term"
          "cosmic-wallpapers"
          "cosmic-workspaces-epoch"
          "xdg-desktop-portal-cosmic"
        ];
      in
      prev.lib.genAttrs pkgNames (
        name:
        (final.callPackage (byName name) { }).overrideAttrs (_: {
          doCheck = false;
        })
      )
    )
  ];
}

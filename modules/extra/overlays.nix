{
  config,
  lib,
  ...
}:

let
  cosmicCfg = config.overlays.cosmic;
in
{
  options.overlays = {
    cosmic = {
      enable = lib.mkEnableOption "the latest COSMIC packages overlay";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cosmicCfg.enable {
      nixpkgs.overlays = [
        (
          final: prev:
          let
            src = prev.fetchFromGitHub {
              owner = "salva09";
              repo = "nixpkgs";
              rev = "789991c4867f1391fdf4be69e9f3fa07a39958c9";
              hash = "sha256-9h1rdPN/doJ6ldWg93baGw+Q3w8ATTgFf7C8tAQr2xI=";
            };

            byName = name: "${src}/pkgs/by-name/${builtins.substring 0 2 name}/${name}/package.nix";

            pkgNames = [
              "cosmic-applets"
              "cosmic-app-library"
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
              "cosmic-protocols"
              "cosmic-monitor"
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
    })
  ];
}

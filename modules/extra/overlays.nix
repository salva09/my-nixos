{
  config,
  lib,
  ...
}:

let
  cosmicCfg = config.overlays.cosmic;
  # futureCfg = config.overlays.futureOverlay;
in
{
  options.overlays = {
    cosmic = {
      enable = lib.mkEnableOption "the latest COSMIC packages overlay";
    };

    # Example Future Overlay Toggle
    # discord-canary = {
    #   enable = lib.mkEnableOption "Discord Canary overlay";
    # };
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
              rev = "c3c4c8bdf9391268af966d1daaf11f360d56b47c";
              hash = "sha256-bi8/qA76wE34jBqmx+oF8SnGF1phto6qMscRqDQqjqk=";
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

    # --- FUTURE OVERLAY PLACEHOLDER ---
    # (lib.mkIf config.overlays.discord-canary.enable {
    #   nixpkgs.overlays = [
    #     (final: prev: {
    #       # your future overlay definitions here
    #     })
    #   ];
    # })
  ];
}

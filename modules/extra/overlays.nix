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
              owner = "thefossguy";
              repo = "nixpkgs";
              rev = "0a4059a6c34e781df8c0c7903b190558b3064b24";
              hash = "sha256-EfTCYAUDjTAknS8XVTsMIrtvSwCcQKktiEC8eBGyPwo=";
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

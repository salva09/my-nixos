{
  config,
  inputs,
  lib,
  ...
}:

let
  isDesktop = config.networking.hostName == "salvas-desktop";

  browsers = [
    "app.zen_browser.zen"
  ];

  communication = [
    "com.discordapp.Discord"
    "org.mozilla.Thunderbird"
    "com.rtosta.zapzap" # WhatsApp
    "org.localsend.localsend_app"
  ];

  productivity = [
    "org.onlyoffice.desktopeditors"
    "io.github.pol_rivero.github-desktop-plus"
    "com.bitwarden.desktop"
    "io.gitlab.news_flash.NewsFlash"
  ];

  creative = [
    "org.blender.Blender"
    "org.godotengine.Godot"
    "org.inkscape.Inkscape"
    "com.icons8.Lunacy"
    "com.orama_interactive.Pixelorama"
    "net.pixieditor.PixiEditor"
    "no.mifi.losslesscut" # Video cutting
  ];

  media = [
    "com.dec05eba.gpu_screen_recorder"
    "info.febvre.Komikku" # Manga reader
  ];

  utilities = [
    "com.ranfdev.DistroShelf"
    "com.usebottles.bottles"
    "org.gnome.Boxes"
    "de.haeckerfelix.Fragments" # Torrent client
    "org.fedoraproject.MediaWriter"
    "ca.desrt.dconf-editor"
    "io.github.fabrialberio.pinapp"
    "io.github.alainm23.planify"
  ];

  gaming = [
    # Launchers
    # "com.valvesoftware.Steam"
    "com.heroicgameslauncher.hgl"
    "org.prismlauncher.PrismLauncher"
    "org.vinegarhq.Sober" # Roblox

    # Utilities
    "com.vysp3r.ProtonPlus"
    "io.github.Foldex.AdwSteamGtk"
    "io.github.radiolamp.mangojuice"
    "io.github.wivrn.wivrn" # VR Streaming
    "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08"
  ];

  themes = [
    "org.gtk.Gtk3theme.adw-gtk3"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
  ];
in
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;

    update.auto = {
      enable = true;
      onCalendar = "daily"; # Default value
    };

    uninstallUnmanaged = true;

    packages = lib.concatLists [
      browsers
      communication
      productivity
      creative
      media
      utilities
      gaming
      themes
    ];

    overrides = {
      global = {
        Context.filesystems = [
          "/nix/store:ro"
          "xdg-config/MangoHud"
        ]
        ++ lib.optionals isDesktop [ "/mnt/data" ];

        Environment = {
          "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
        };
      };

      "org.vinegarhq.Sober".Context = {
        filesystems = [
          "xdg-run/app/com.discordapp.Discord:create"
          "xdg-run/discord-ipc-0"
        ];

        devices = [
          "input"
        ];
      };

      "org.localsend.localsend_app".Context = {
        filesystems = [
          "home"
        ];
      };
    };
  };
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
    uninstallUnmanaged = true;
    packages = [
      "app.zen_browser.zen"
      "com.bitwarden.desktop"
      "com.dec05eba.gpu_screen_recorder"
      "com.discordapp.Discord"
      "com.ranfdev.DistroShelf"
      "com.valvesoftware.Steam"
      "com.vysp3r.ProtonPlus"
      "io.github.Foldex.AdwSteamGtk"
      "io.github.pol_rivero.github-desktop-plus"
      "io.github.tobagin.karere"
      "io.github.wivrn.wivrn"
      "org.blender.Blender"
      "org.godotengine.Godot"
      "org.inkscape.Inkscape"
      "org.localsend.localsend_app"
      "org.mozilla.Thunderbird"
      "org.onlyoffice.desktopeditors"
      "org.prismlauncher.PrismLauncher"
      "org.vinegarhq.Sober"
      "com.heroicgameslauncher.hgl"
      "ca.desrt.dconf-editor"
      "com.icons8.Lunacy"
      "com.orama_interactive.Pixelorama"
      "com.usebottles.bottles"
      "io.gitlab.news_flash.NewsFlash"
      "net.pixieditor.PixiEditor"
      "no.mifi.losslesscut"
      "org.gnome.Boxes"
    ];
  };
}

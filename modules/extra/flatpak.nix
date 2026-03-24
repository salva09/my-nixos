{
  inputs,
  ...
}:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;

    update.auto = {
      enable = false;
      onCalendar = "daily"; # Default value
    };

    uninstallUnmanaged = false;

    packages = [
      "io.github.kolunmi.Bazaar"
    ];

    overrides = {
      global = {
        Context.filesystems = [
          "/nix/store:ro"
          "/mnt/data"
        ];
      };
    };
  };
}

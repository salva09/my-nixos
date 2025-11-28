{ config, pkgs, inputs, ... }:

{
  programs.niri.enable = true;
  
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  
  # import the nixos module
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  
  # enable the systemd service
  services.noctalia-shell.enable = true;
  
  # To add support for events in the calendar via evolution-data-server.
  services.gnome.evolution-data-server.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite # xwayland support
    (python3.withPackages (pyPkgs: with pyPkgs; [ pygobject3 ]))
  ];

  environment.sessionVariables = {
    GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" (
      with pkgs;
      [
        evolution-data-server
        libical
        glib.out
        libsoup_3
        json-glib
        gobject-introspection
      ]
    );
  };
}

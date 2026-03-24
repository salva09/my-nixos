{ pkgs, ... }:

{
  hardware.uinput.enable = true;
  hardware.steam-hardware.enable = true;

  services.udev.packages = [
    pkgs.game-devices-udev-rules
  ];

  services.udev.extraRules = ''
    # Keychron M6 Mouse (USB)
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0666", GROUP="users"

    # Keychron M6 Mouse (2.4GHz Dongle)
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0360", MODE="0666", GROUP="users"

    # YARG udev rules to access controllers
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666"
  '';
}

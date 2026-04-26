{ ... }:

{
  services.dbus.implementation = "broker";

  services.upower.enable = true;
  services.libinput.enable = true;

  hardware.i2c.enable = true;
  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.tuned.enable = true;

  services.flatpak.enable = true;
}

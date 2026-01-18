{ pkgs, ... }:

{
  services.dbus.implementation = "broker";

  services.upower.enable = true;
  services.libinput.enable = true;
  hardware.uinput.enable = true;

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
}

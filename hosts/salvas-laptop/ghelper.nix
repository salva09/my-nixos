{ pkgs, ... }:

{
  services.udev.extraRules = ''
    # G-Helper Linux — udev rules for non-root access to ASUS hardware controls
    # Version: 1.0.70

    # ── asus-nb-wmi platform device ──
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{throttle_thermal_policy}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{panel_od}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/panel_od"

    # PPT power limits (kernel 6.2+)
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{ppt_pl1_spl}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/ppt_pl1_spl"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{ppt_pl2_sppt}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/ppt_pl2_sppt"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{ppt_fppt}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/ppt_fppt"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{nv_dynamic_boost}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/nv_dynamic_boost"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{nv_temp_target}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/nv_temp_target"

    # Additional PPT power limits (less common, but present on some models)
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{ppt_apu_sppt}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/ppt_apu_sppt"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{ppt_platform_sppt}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/ppt_platform_sppt"

    # Fallback: batch-chmod ALL PPT attributes when asus-nb-wmi appears.
    # Note the $$attr escaping here
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    RUN+="${pkgs.bash}/bin/sh -c 'for attr in ppt_pl1_spl ppt_pl2_sppt ppt_fppt ppt_apu_sppt ppt_platform_sppt nv_dynamic_boost nv_temp_target; do [ -f /sys/devices/platform/asus-nb-wmi/$$attr ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/$$attr; done'"

    # eGPU and boot sound
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{egpu_enable}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/egpu_enable"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{boot_sound}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/devices/platform/asus-nb-wmi/boot_sound"

    # platform_profile + CPU boost
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/firmware/acpi/platform_profile ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/firmware/acpi/platform_profile'"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/system/cpu/intel_pstate/no_turbo; [ -f /sys/devices/system/cpu/cpufreq/boost ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/system/cpu/cpufreq/boost'"

    # ── asus-nb-wmi bus device ──
    # GPU Eco mode, MUX switch, Mini LED
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{dgpu_disable}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/bus/platform/devices/asus-nb-wmi/dgpu_disable"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{gpu_mux_mode}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/bus/platform/devices/asus-nb-wmi/gpu_mux_mode"

    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    ATTR{mini_led_mode}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/bus/platform/devices/asus-nb-wmi/mini_led_mode"

    # PCI bus rescan
    SUBSYSTEM=="platform", DRIVER=="asus-nb-wmi", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/bus/pci/rescan"

    # ── Battery charge limit ──
    SUBSYSTEM=="power_supply", ATTR{type}=="Battery", \
    ATTR{charge_control_end_threshold}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 $sys$devpath/charge_control_end_threshold"

    # ── Keyboard backlight ──
    SUBSYSTEM=="leds", KERNEL=="asus::kbd_backlight", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/leds/asus::kbd_backlight/brightness"

    SUBSYSTEM=="leds", KERNEL=="asus::kbd_backlight", \
    ATTR{multi_intensity}!="", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/leds/asus::kbd_backlight/multi_intensity"

    # TUF Gaming keyboards: RGB mode control
    SUBSYSTEM=="leds", KERNEL=="asus::kbd_backlight", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode'"

    # TUF Gaming keyboards: RGB power state control
    SUBSYSTEM=="leds", KERNEL=="asus::kbd_backlight", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/class/leds/asus::kbd_backlight/kbd_rgb_state ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/class/leds/asus::kbd_backlight/kbd_rgb_state'"

    # ── Fan curves (hwmon) ──
    # Note the $$f escaping here
    SUBSYSTEM=="hwmon", ATTR{name}=="asus_nb_wmi", \
    RUN+="${pkgs.bash}/bin/sh -c 'for f in /sys/class/hwmon/%k/pwm*_auto_point*; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"

    SUBSYSTEM=="hwmon", ATTR{name}=="asus_nb_wmi", \
    RUN+="${pkgs.bash}/bin/sh -c 'for f in /sys/class/hwmon/%k/pwm*_enable; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"

    # ── CPU boost ──
    ACTION=="add|change", SUBSYSTEM=="module", KERNEL=="intel_pstate", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/system/cpu/intel_pstate/no_turbo'"

    ACTION=="add|change", SUBSYSTEM=="module", KERNEL=="acpi_cpufreq", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/devices/system/cpu/cpufreq/boost ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/system/cpu/cpufreq/boost'"

    SUBSYSTEM=="cpu", ACTION=="add", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/system/cpu/intel_pstate/no_turbo; [ -f /sys/devices/system/cpu/cpufreq/boost ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/devices/system/cpu/cpufreq/boost; [ -f /sys/firmware/acpi/platform_profile ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/firmware/acpi/platform_profile'"

    # ── ACPI platform profile ──
    ACTION=="add|change", SUBSYSTEM=="acpi", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/firmware/acpi/platform_profile ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/firmware/acpi/platform_profile'"

    # ── Fan curves (asus_custom_fan_curve hwmon, newer kernels) ──
    SUBSYSTEM=="hwmon", ATTR{name}=="asus_custom_fan_curve", \
    RUN+="${pkgs.bash}/bin/sh -c 'for f in /sys/class/hwmon/%k/pwm*_auto_point*; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"

    SUBSYSTEM=="hwmon", ATTR{name}=="asus_custom_fan_curve", \
    RUN+="${pkgs.bash}/bin/sh -c 'for f in /sys/class/hwmon/%k/pwm*_enable; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"

    # ── ASUS input devices (hotkeys) ──
    SUBSYSTEM=="input", ATTRS{name}=="Asus WMI hotkeys", MODE="0666"
    SUBSYSTEM=="input", KERNEL=="event*", ATTRS{id/vendor}=="0b05", MODE="0666"

    # ── ASUS HID devices (AURA RGB keyboard control) ──
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0b05", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", MODE="0666"
    SUBSYSTEM=="hidraw", ACTION=="add", \
    RUN+="${pkgs.bash}/bin/sh -c '${pkgs.gnugrep}/bin/grep -q 00000B05 /sys%p/device/uevent 2>/dev/null && ${pkgs.coreutils}/bin/chmod 0666 /dev/%k'"

    # ── Backlight ──
    SUBSYSTEM=="backlight", ACTION=="add", \
    RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys%p/brightness"

    # ── PCIe ASPM policy ──
    ACTION=="add|change", SUBSYSTEM=="module", KERNEL=="pcie_aspm", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/module/pcie_aspm/parameters/policy ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/module/pcie_aspm/parameters/policy'"

    # ── ASUS firmware-attributes (asus-armoury, kernel 6.8+) ──
    ACTION=="add|change", SUBSYSTEM=="firmware-attributes", \
    RUN+="${pkgs.bash}/bin/sh -c 'for f in /sys/class/firmware-attributes/asus-armoury/attributes/*/current_value; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"

    ACTION=="add|change", SUBSYSTEM=="module", KERNEL=="asus_armoury", \
    RUN+="${pkgs.bash}/bin/sh -c '${pkgs.coreutils}/bin/sleep 1; for f in /sys/class/firmware-attributes/asus-armoury/attributes/*/current_value; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"

    # ── ryzen_smu (Curve Optimizer undervolting) ──
    ACTION=="add|change", SUBSYSTEM=="module", KERNEL=="ryzen_smu", \
    RUN+="${pkgs.bash}/bin/sh -c '${pkgs.coreutils}/bin/chmod 0666 /sys/kernel/ryzen_smu_drv/rsmu_cmd /sys/kernel/ryzen_smu_drv/smu_args 2>/dev/null || true'"

    SUBSYSTEM=="cpu", KERNEL=="cpu0", ACTION=="add|change", \
    RUN+="${pkgs.bash}/bin/sh -c '[ -f /sys/kernel/ryzen_smu_drv/rsmu_cmd ] && ${pkgs.coreutils}/bin/chmod 0666 /sys/kernel/ryzen_smu_drv/rsmu_cmd /sys/kernel/ryzen_smu_drv/smu_args'"

    # ── CPU online/offline (core toggling) ──
    SUBSYSTEM=="cpu", ACTION=="add", \
    RUN+="${pkgs.bash}/bin/sh -c 'for f in /sys/devices/system/cpu/cpu*/online; do [ -f \"$$f\" ] && ${pkgs.coreutils}/bin/chmod 0666 \"$$f\"; done'"
  '';
}

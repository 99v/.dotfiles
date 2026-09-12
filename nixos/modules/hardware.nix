{
  pkgs,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      intel-compute-runtime
      libvdpau-va-gl
      libva-utils
      vulkan-loader
      vulkan-validation-layers
    ];
  };

  hardware.ksm.enable = true;

  hardware.cpu.x86.msr.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General.Experimental = true;
  services.blueman.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND = 1;
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_AC = 90;
      CPU_MAX_PERF_ON_BAT = 50;
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      SATA_LINK_PWR_ON_AC = "med_power_with_dipm";
      SATA_LINK_PWR_ON_BAT = "min_power";
    };
  };

  services.undervolt = {
    enable = true;
    coreOffset = -50;
    gpuOffset = -15;
    uncoreOffset = -10;
    p1 = {
      limit = 20;
      window = 28;
    };
    p2 = {
      limit = 30;
      window = 2.0;
    };
  };

  services.thinkfan = {
    enable = true;
    sensors = [
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
      }
    ];
    levels = [
      [
        0
        0
        58
      ]
      [
        1
        50
        66
      ]
      [
        3
        58
        74
      ]
      [
        5
        66
        82
      ]
      [
        7
        74
        32767
      ]
    ];
  };

  services.thermald.enable = false;
  services.fwupd.enable = true;

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "1";
    };
    touchpad.additionalOptions = ''
      Option "Ignore" "on"
    '';
  };

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="serio*", ATTR{sensitivity}="250"
    ACTION=="add|change", KERNEL=="serio*", ATTR{speed}="250"
  '';
}

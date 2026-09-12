{
  pkgs,
  ...
}:

{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      cores = 4;
      max-jobs = 1;
      always-allow-substitutes = true;
    };
  };

  console = {
    enable = true;
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    initrd = {
      checkJournalingFS = false;
      systemd.enable = true;
      compressor = "zstd";
      includeDefaultModules = false;
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelModules = [
      "thinkpad_acpi"
      "snd-seq"
      "snd-seq-midi"
    ];
    supportedFilesystems = [
      "ntfs"
      "exfat"
    ];

    kernelParams = [
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "i915.enable_psr=1"
      "thinkpad_acpi.fan_control=1"
      "transparent_hugepage=always"
      "mem_sleep_default=deep"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];

  services.fstrim.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  environment.variables.EDITOR = "vim";
}

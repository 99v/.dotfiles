{
  pkgs,
  lib,
  ...
}:

{
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
        ];
      };
    };
  };

  services.mpd = {
    enable = true;
    user = "user";
    musicDirectory = "/home/user/Audio";
    settings = {
      audio_output = [
        {
          type = "alsa";
          name = "Snowsky Nano Direct";
          device = "hw:CARD=NANO,DEV=0";
          mixer_type = "hardware";
          "auto_resample" = "no";
          "auto_format" = "no";
          "dop" = "yes";
        }
        {
          type = "fifo";
          name = "Visualizer Feed";
          path = "/tmp/mpd.fifo";
          format = "44100:16:2";
        }
      ];
    };
  };

  systemd.services.mpd.wantedBy = lib.mkForce [ ];
  systemd.sockets.mpd.wantedBy = [ "sockets.target" ];

  services.kanata = {
    enable = true;
    keyboards = {
      myKeys = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        configFile = ./kanata/kanata.kbd;
        extraArgs = [ "-q" ];
      };
    };
  };
  systemd.services."kanata-myKeys" = {
    serviceConfig = {
      Type = lib.mkForce "simple";
      CPUSchedulingPolicy = "idle";
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    onShutdown = "suspend";
  };
  systemd.services.libvirtd.wantedBy = lib.mkForce [ ];
  systemd.services.systemd-machined.wantedBy = lib.mkForce [ ];
  programs.virt-manager.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  systemd.user.settings.Manager = {
    DefaultDelegate = "yes";
  };

  environment.etc."containers/containers.conf".text = pkgs.lib.mkForce ''
    [engine]
    cgroup_manager = "cgroupfs"
    events_logger = "file"
  '';

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 5;
    extraArgs = [
      "-g"
      "--prefer"
      "^(.*/)?(electron|qutebrowser|firefox|chromium|nix-daemon)$"
      "--avoid"
      "^(.*/)?(sway|dbus|systemd)$"
    ];
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;
}

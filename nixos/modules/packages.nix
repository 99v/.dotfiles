{
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.lixPackageSets.stable.lix;

  nixpkgs.overlays = [
    (final: prev: {
      llama-cpp = prev.llama-cpp.override {
        openclSupport = true;
      };
    })

    (final: prev: {
      inherit (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  environment.systemPackages = with pkgs; [
    wget
    vim
    dnsutils
    foot
    foot.terminfo
    chafa
    libsixel
    python312Packages.pillow
    ffmpegthumbnailer
    file
    yazi
    poppler
    fontconfig
    imagemagick
    viu
    alacritty
    alacritty.terminfo
    ncurses
    xdg-utils
    rofi
    ncdu
    tmux
    screen
    byobu
    qutebrowser
    firefox
    ffmpeg
    google-chrome
    (mpv.override {
      scripts = [
        mpvScripts.uosc
        mpvScripts.thumbfast
      ];
    })
    mpvpaper
    yt-dlp
    sshuttle
    nix-search-cli
    fastfetch
    fetch
    dmidecode
    lm_sensors
    viddy
    btop
    telegram-desktop
    qbittorrent
    openvpn
    openvpn3
    unzip
    p7zip
    wireguard-tools
    wev
    wl-clipboard
    wlroots
    grim
    satty
    slurp
    ksnip
    clipse
    flameshot
    swaynotificationcenter
    libnotify
    autotiling
    swaybg
    waypipe
    tree
    yazi
    nautilus
    glib
    git
    tig
    delta
    broot
    ranger
    sxiv
    swayimg
    imv
    libinput
    (inputs.vortix.packages.${pkgs.stdenv.hostPlatform.system}.default)
    bibata-cursors
    phinger-cursors
    llama-cpp
    clinfo
    quickemu
    undervolt
    stress-ng
    nwg-look
    nwg-displays
    vesktop
    android-tools
    scrcpy
    udiskie
    mousepad
    easyeffects
    speedtest-cli
    waybar
    filezilla
    zathura
    socat
    sshpass
    gcc
    linuxHeaders
    translate-shell

    (runCommand "wtf-only" { } ''
      mkdir -p $out/bin $out/share
      cp -d ${bsdgames}/bin/wtf $out/bin/
      cp -rd ${bsdgames}/share/misc $out/share/
    '')

    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-vaapi
      ];
    })

    mpd
    ncmpcpp
    mpc
    blanket
    xaos
    lue
    espeak-ng
    tldr
    iperf3
    vulkan-tools
    iotop
    nh
    nvd
    nix-output-monitor
    nix-tree
    jq
    wezterm
    go
    qtractor
    qjackctl
    calf
    swh_lv2
    distrobox
    tmate
    zellij
    gaiasky
    termshark
    moonlight-qt
    freerdp
    remmina
    virt-viewer
    cliphist
    clipman
    xwayland-satellite
    terminaltexteffects
    nerdfetch
    bat
    pv
    bottom
    eza
    fuzzel
    trippy
    wtype
    fontconfig
    rustc
    cargo
    gnumake
    gcc
    pkg-config
    lazygit
  ];
}

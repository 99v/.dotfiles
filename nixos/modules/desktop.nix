{
  pkgs,
  lib,
  ...
}:

{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.variables.WLR_DRM_NO_ATOMIC = "1";

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    PATH = [ "$HOME/.cargo/bin" ];
  };

  environment.variables = {
    XCURSOR_PATH = lib.mkForce [
      "$HOME/.icons"
      "$HOME/.local/share/icons"
      "/run/current-system/sw/share/icons"
    ];
    XCURSOR_THEME = lib.mkDefault "phinger-cursors-light";
    XCURSOR_SIZE = lib.mkDefault "48";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.niri.enable = true;

  programs.dconf.enable = true;
  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  services.getty.autologinUser = "user";
  services.getty.greetingLine = ''
    <<< \e[1;32mWelcome to NixOS (\e[1;36m\m\e[1;32m)\e[0m >>>
    \e[1;33mTTY: \l | Node: \n\e[0m
  '';

  systemd.user.services.udiskie = {
    description = "udiskie automounter";
    wantedBy = [
      "graphical-session.target"
      "default.target"
    ];
    serviceConfig.ExecStart = "${pkgs.udiskie}/bin/udiskie";
  };

  systemd.services.disable-thinkpad-led = {
    description = "Disable thinkpad power led on boot";
    after = [
      "multi-user.target"
      "suspend.target"
      "hibernate.target"
    ];
    wantedBy = [
      "multi-user.target"
      "suspend.target"
      "hibernate.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c \"echo '0 off' > /proc/acpi/ibm/led || true\"";
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

}

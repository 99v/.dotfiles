{
  networking.hostName = "system";
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
      NameResolvingService = "systemd";
    };
    Settings = {
      AutoConnect = true;
    };
    Network = {
      RoutePriorityOffset = 300;
    };
  };

  networking.useNetworkd = true;
  networking.networkmanager.enable = false;
  networking.dhcpcd.enable = false;
  networking.networkmanager.dns = "none";
  networking.firewall.enable = true;
  services.resolved.enable = true;
}

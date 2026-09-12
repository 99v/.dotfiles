{
  pkgs,
  ...
}:

{
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "audio"
      "video"
      "wheel"
      "input"
      "libvirtd"
      "kvm"
      "qemu-libvirtd"
      "adbusers"
      "podman"
    ];
    packages = with pkgs; [
      kitty
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "user" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/tee /proc/acpi/ibm/led";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/btop";
          options = [
            "NOPASSWD"
            "SETENV"
          ];
        }
      ];
    }
  ];
}

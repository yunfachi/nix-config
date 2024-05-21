{config, ...}: {
  host.type = "desktop";

  yunfachi = {
    system = {
      amd-gpu.enable = true;
    };

    hardware.displays = [
      {
        id = "eDP-1";
        primary = true;
        refreshRate = 60;
      }
    ];

    services = {
      wireguard.privateKeyFile = config.sops.secrets."wireguard/clients/ayane/privateKey".path;
    };
  };
}

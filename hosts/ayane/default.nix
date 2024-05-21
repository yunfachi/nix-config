{config, ...}: {
  host.type = "desktop";

  yunfachi = {
    system = {
      amd-gpu.enable = true;
    };

    services = {
      wireguard.privateKeyFile = config.sops.secrets."wireguard/clients/ayane/privateKey".path;
    };
  };
}

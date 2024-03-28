{config, ...}: {
  host.type = "server";

  yunfachi = {
    infras = {
      changelog.enable = true;
      deshiro.enable = true;
    };
    services = {
      archisteamfarm.enable = true;
      wireguard = {
        enable = true;
        privateKeyFile = config.sops.secrets."hosts/dekomori/wireguard/privateKey".path;
      };
    };
  };
}

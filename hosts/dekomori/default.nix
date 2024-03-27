{...}: {
  host.type = "server";
  yunfachi = {
    infras = {
      changelog.enable = true;
      deshiro.enable = true;
    };
    services = {
      archisteamfarm.enable = true;
    };
  };
}

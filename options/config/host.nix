{option-functions, ...}:
with option-functions;
  rootOption null "host" (cfg: {
    name = textOption "name" null;
    type = enumOption "type" null ["server" "desktop"];

    isServer = enableOption "isServer" (cfg.type == "server");
    isDesktop = enableOption "isDesktop" (cfg.type == "desktop");
  })

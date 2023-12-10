{host, ...}: {
  networking = {
    hostName = host;
    networkmanager.enable = true;
    wireless.enable = false;
  };
}

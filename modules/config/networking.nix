{
  user,
  host,
  ...
}: {
  networking = {
    hostName = host.name;

    networkmanager.enable = true;
  };
  user.extraGroups = ["networkmanager"];
}

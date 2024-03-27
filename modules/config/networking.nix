{
  user,
  host,
  ...
}: {
  networking = {
    hostName = host.name;

    firewall.enable = true;
    networkmanager.enable = true;
  };
  user.extraGroups = ["networkmanager"];
}

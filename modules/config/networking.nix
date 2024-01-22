{
  module-functions,
  user,
  host,
  ...
}: {
  networking = {
    hostName = host;

    networkmanager.enable = true;
  };
  user.extraGroups = ["networkmanager"];
}

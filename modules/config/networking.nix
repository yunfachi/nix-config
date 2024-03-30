{
  user,
  host,
  lib,
  ...
}: {
  networking = {
    hostName = host.name;

    firewall.enable = true;
    networkmanager.enable = true;
    # nameservers = ["1.1.1.1" "1.0.0.1"];
  };
  user.extraGroups = ["networkmanager"];

  environment.etc = {
    "resolv.conf".text = ''
      nameserver 1.1.1.1
      nameserver 1.0.0.1
    '';
  };
}

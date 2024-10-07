{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.wireshark";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled = {
    users.groups.wireshark = {};
    user.extraGroups = ["wireshark"];

    security.wrappers.dumpcap = {
      source = "${pkgs.wireshark}/bin/dumpcap";
      capabilities = "cap_net_raw,cap_net_admin+eip";
      owner = "root";
      group = "wireshark";
      permissions = "u+rx,g+x";
    };
  };

  home.ifEnabled.home.packages = [pkgs.wireshark];
}

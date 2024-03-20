{
  module-functions,
  pkgs,
  user,
  ...
}:
module-functions.module "programs" "wireshark" {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  user.extraGroups = ["wireshark"];
}

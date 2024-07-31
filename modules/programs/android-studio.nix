{
  module-functions,
  hm,
  pkgs,
  user,
  ...
}:
module-functions.module "programs" "android-studio" {
  user.extraGroups = ["kvm" "adbusers"];
  hm.home.packages = with pkgs; [androidStudioPackages.dev];
  programs.adb.enable = true;
}

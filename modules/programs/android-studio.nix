{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.android-studio";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
    users.groups.adbusers = {};
    user.extraGroups = ["kvm" "adbusers"];
  };

  home.ifEnabled.home.packages = with pkgs; [android-tools android-studio];
}

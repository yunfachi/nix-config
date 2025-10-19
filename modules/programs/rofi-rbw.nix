{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.rofi-rbw";

  options =
    { myconfig, ... }:
    {
      programs.rofi-rbw = {
        enable = delib.boolOption (myconfig.programs.rofi.enable && myconfig.programs.rbw.enable);
      };
    };
  home.ifEnabled.home.packages = with pkgs; [
    rofi-rbw-wayland
  ];
}

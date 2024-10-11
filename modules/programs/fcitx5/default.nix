{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fcitx5";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.ifEnabled.commands.windowManager.onStartup = [
    "fcitx5 -d --replace"
  ];

  home.ifEnabled = {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };

    home.sessionVariables.SDL_IM_MODULE = "fcitx";
  };
}

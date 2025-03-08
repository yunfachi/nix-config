{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.fcitx5";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];
      };
    };
  };
}

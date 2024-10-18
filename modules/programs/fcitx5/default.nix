{
  delib,
  pkgs,
  host,
  lib,
  ...
}:
delib.module {
  name = "programs.fcitx5";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled = {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };

    systemd.user.services.fcitx5-daemon = {
      Unit.PartOf = lib.mkForce [];
      Install.WantedBy = lib.mkForce [];
    };

    home.sessionVariables.SDL_IM_MODULE = "fcitx";
  };
}

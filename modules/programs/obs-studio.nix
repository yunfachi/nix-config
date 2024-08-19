{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.obs-studio";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled.programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };
}

{
  delib,
  host,
  decryptSecret,
  ...
}:
delib.module {
  name = "wakatime";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled = {
    home.file.".wakatime.cfg".text = ''
      [settings]
      api_key = ${decryptSecret "wakatime/api_key"}
    '';
  };
}

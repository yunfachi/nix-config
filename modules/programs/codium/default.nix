{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.codium";

  options = {myconfig, ...}: {
    programs.codium = with delib; {
      enable = boolOption host.isDesktop;
      extensions = {
        wakatime = boolOption myconfig.wakatime.enable;
        alejandra = boolOption myconfig.programs.alejandra.enable;
      };
    };
  };

  home.ifEnabled.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}

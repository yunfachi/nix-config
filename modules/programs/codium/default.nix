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
      enable = boolOption host.guiFeatured;
      extensions = {
        wakatime = boolOption myconfig.wakatime.enable;
        nixfmt = boolOption myconfig.programs.nixfmt.enable;
      };
    };
  };

  home.ifEnabled.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}

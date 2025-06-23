{
  delib,
  homeconfig,
  lib,
  constants,
  ...
}:
delib.module {
  name = "programs.bash";

  options.programs.bash = with delib; {
    enable = boolOption true;
    historyFile = strOption (homeconfig.home.homeDirectory + "/.bash_history");
    historySize = intOption 10000;
  };

  myconfig.ifEnabled = {cfg, ...}: {
    persist = let
      cond = lib.hasPrefix homeconfig.home.homeDirectory cfg.historyFile;
      val = path: {
        file = path;
        # FIXME: https://github.com/nix-community/impermanence/issues/273
        # mode = "u=rw,g=,o=";
      };
    in {
      user.files = lib.mkIf cond [(val (lib.removePrefix homeconfig.home.homeDirectory cfg.historyFile))];
      files = lib.mkIf (!cond) [(val cfg.historyFile)];
    };
  };

  home.ifEnabled = {cfg, ...}: {
    programs.bash = {
      enable = true;

      historyControl = ["erasedups" "ignorespace"];
      inherit (cfg) historyFile historySize;

      initExtra = ''
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
      '';
    };
  };
}

{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.git";

  options.programs.git = with delib; {
    enable = boolOption true;
    signingKey = allowNull (strOption null);
  };

  home.ifEnabled = {
    myconfig,
    cfg,
    ...
  }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      signing = lib.mkIf (cfg.signingKey != null) {
        key = cfg.signingKey;
        signByDefault = true;
      };

      settings = {
        user = {
          name = myconfig.constants.username;
          email = myconfig.constants.useremail;
        };

        init.defaultBranch = "master";
      };
    };
  };

  nixos.ifEnabled.environment.systemPackages = [pkgs.git];
}

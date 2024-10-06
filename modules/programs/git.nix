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

      userName = myconfig.constants.username;
      userEmail = myconfig.constants.useremail;

      signing = lib.mkIf (cfg.signingKey != null) {
        key = cfg.signingKey;
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "master";
      };
    };
  };

  nixos.ifEnabled.environment.systemPackages = [pkgs.git];
}

{
  config,
  lib,
  userfullname,
  useremail,
  ...
}: let
  cfg = config.yunfachi.git;
in {
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = userfullname;
      userEmail = useremail;

      extraConfig = {
        init.defaultBranch = "master";
        push.autoSetupRemote = true;
        pull.rebase = true;

        # replace https with ssh
        url = {
          "ssh://git@github.com/" = {
            insteadOf = "https://github.com/";
          };
          "ssh://git@gitlab.com/" = {
            insteadOf = "https://gitlab.com/";
          };
          "ssh://git@bitbucket.com/" = {
            insteadOf = "https://bitbucket.com/";
          };
        };
      };
    };
  };
}

{
  module-functions,
  hm,
  username,
  useremail,
  ...
}:
module-functions.module "programs" "git" {
  hm.programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;

    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}

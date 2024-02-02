{module-functions, ...}:
module-functions.module "programs" "steam" {
  programs.steam = {
    enable = true;

    #remotePlay.openFirewall = true;
  };
}

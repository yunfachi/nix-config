{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.ssh";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.ssh = {
    enable = true;

    package = pkgs.openssh_hpn;
    compression = true;
    hashKnownHosts = true;
  };
}

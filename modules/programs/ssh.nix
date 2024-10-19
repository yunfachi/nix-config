{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.ssh";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.persist.user.files = [
    ".ssh/id_ed25519"
    ".ssh/id_ed25519.pub"
    ".ssh/known_hosts"
  ];

  home.ifEnabled.programs.ssh = {
    enable = true;

    package = pkgs.openssh_hpn;
    compression = true;
    hashKnownHosts = true;
  };
}

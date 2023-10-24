{config, ...}: rec {
  systemd.user.sessionVariables = {
    # set default applications
    BROWSER = "firefox";
    TERM = "xterm-256color";
  };

  home.sessionVariables = systemd.user.sessionVariables;
}

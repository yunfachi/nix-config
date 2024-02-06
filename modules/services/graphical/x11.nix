{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "services" "x11" {
  hm.xsession.enable = true;

  services.xserver.displayManager = {
    defaultSession = "none+hm-session";

    session = [
      {
        name = "hm-session";
        manage = "window";
        start = ''
          ${pkgs.runtimeShell} $HOME/.xsession &
          waitPID=$!
        '';
      }
    ];
  };
}

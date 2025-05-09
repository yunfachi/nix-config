{
  delib,
  host,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.nautilus";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled = {myconfig, ...}: {
    persist.user.directories = [".cache/thumbnails"];

    dconf.settings."com/github/stunkymonkey/nautilus-open-any-terminal".terminal = lib.mkIf myconfig.programs.kitty.enable "kitty";
  };

  home.ifEnabled.home = let
    nautilusEnv = pkgs.buildEnv {
      name = "nautilus-env";

      paths = with pkgs; [
        nautilus

        nautilus-python
        nautilus-open-any-terminal
        sushi

        #gvfs
      ];
    };
  in {
    packages = [nautilusEnv];
    sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${nautilusEnv}/lib/nautilus/extensions-4";
  };
}

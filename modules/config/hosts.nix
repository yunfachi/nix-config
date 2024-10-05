{delib, ...}:
delib.module {
  name = "hosts";

  options = with delib; let
    host = {config, ...}: {
      options =
        hostSubmoduleOptions
        // {
          type = noDefault (enumOption ["desktop" "server"] null);

          isDesktop = boolOption (config.type == "desktop");
          isServer = boolOption (config.type == "server");

          displays = listOfOption (submodule {
            options = {
              enable = boolOption true;
              touchscreen = boolOption false;

              # e.g. DP-1, HDMI-A-1
              name = noDefault (strOption null);
              primary = boolOption (builtins.length config.displays == 1);
              refreshRate = intOption 60;

              width = intOption 1920;
              height = intOption 1080;
              x = intOption 0;
              y = intOption 0;
            };
          }) [];
        };
    };
  in {
    host = hostOption host;
    hosts = hostsOption host;
  };

  myconfig.always = {myconfig, ...}: {
    args.shared = {
      inherit (myconfig) host hosts;
    };
  };

  nixos.always = {myconfig, ...}: {
    boot.kernelParams = map (display: with display; "video=${name}:${toString width}x${toString height}@${toString refreshRate}") myconfig.host.displays;
  };

  home.always = {myconfig, ...}: {
    assertions = delib.hostNamesAssertions myconfig.hosts;
  };
}

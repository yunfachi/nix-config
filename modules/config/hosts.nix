{delib, ...}:
delib.module {
  name = "hosts";

  options = with delib; let
    allFeatures = ["cli" "gui" "gaming" "hacking" "powersave"];

    host = {config, ...}: {
      options =
        hostSubmoduleOptions
        // {
          type = noDefault (enumOption ["desktop" "server"] null);

          isDesktop = boolOption (config.type == "desktop");
          isServer = boolOption (config.type == "server");

          # cli: not must-have (ssh, git, gpg, fail2ban, dnscrypt) utilities like eza, bat, nh, etc.
          # gui: gui applications and modules that are needed only for gui applications (gnome-keyring, wakatime)
          features =
            listOfOption (enum allFeatures)
            {
              desktop = ["cli" "gui" "gaming" "hacking"];
              server = [""];
            }
            .${config.type};

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
        }
        // builtins.listToAttrs (
          map (feature: {
            name = "${feature}Featured";
            value = boolOption (builtins.elem feature config.features);
          })
          allFeatures
        );
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

{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "bluetooth";

  options.bluetooth = with delib; {
    enable = boolOption false;
    enableMprisProxy = boolOption true;
  };

  myconfig.ifEnabled.persist.directories = ["/var/lib/bluetooth"];

  nixos.ifEnabled = {
    hardware.bluetooth = {
      enable = true;

      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    services.blueman.enable = true;
    environment.systemPackages = [pkgs.gparted];
  };

  home.ifEnabled = {cfg, ...}: {
    services.mpris-proxy.enable = cfg.enableMprisProxy;

    services.blueman-applet.enable = true;
  };
}

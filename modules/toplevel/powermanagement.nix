{
  delib,
  host,
  ...
}:
delib.module {
  name = "powerManagement";

  options.powerManagement = with delib; {
    enable = boolOption true;

    cpuFreqGovernor = enumOption ["performance" "ondemand" "powersave"] (
      if host.powersaveFeatured
      then "powersave"
      else "performance"
    );
  };

  nixos.ifEnabled = {cfg, ...}: {
    powerManagement = {
      enable = true;
      inherit (cfg) cpuFreqGovernor;
    };
  };

  nixos.ifDisabled.powerManagement.enable = false;
}

{delib, ...}:
delib.module {
  name = "powerManagement";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance"; #TODO: fix for laptops
  };
  nixos.ifDisabled.powerManagement.enable = false;
}

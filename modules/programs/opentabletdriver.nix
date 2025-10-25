{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.opentabletdriver";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled.hardware.opentabletdriver.enable = true;
}

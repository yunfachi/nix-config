{
  delib,
  host,
  ...
}:
delib.module {
  name = "graphics";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled.hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}

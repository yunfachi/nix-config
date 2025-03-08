{
  delib,
  host,
  ...
}:
delib.module {
  name = "graphics";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}

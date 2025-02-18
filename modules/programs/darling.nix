{delib, ...}:
delib.module {
  name = "programs.darling";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.programs.darling.enable = true;
}

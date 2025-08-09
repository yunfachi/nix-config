{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "nixowos";

  options = delib.singleEnableOption true;

  nixos.always.imports = [inputs.nixowos.nixosModules.default];

  nixos.ifEnabled.nixowos = {
    enable = true;
  };
}

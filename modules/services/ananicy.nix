{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "services.ananicy";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled.services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}

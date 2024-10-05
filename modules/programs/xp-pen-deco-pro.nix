{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.xp-pen-deco-pro";

  options = delib.singleEnableOption false;

  # so far deco 01 and deco pro drivers are the same file
  home.ifEnabled.home.packages = [pkgs.xp-pen-deco-01-v2-driver];
  nixos.ifEnabled.environment.systemPackages = [pkgs.xp-pen-deco-01-v2-driver];
}

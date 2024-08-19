{
  module-functions,
  inputs,
  pkgs,
  ...
}:
module-functions.moduleIfEnabledFinally "system" "grub" (cfg: {
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = cfg.mode == "uefi";
      devices = ["nodev"];
      configurationLimit = 1;
    };

    grub2-theme = {
      enable = true;
      theme = "stylish";
      icon = "whitesur";
      splashImage = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/1k/wallhaven-1kpqw9.jpg";
        hash = "sha256-C7w/kRuy5Ho+IeXkfECUYwsP+5pAkUdR9/zVEFsBrEU=";
      };
    };
  };
})
{
  imports = [inputs.grub2-themes.nixosModules.default];
}

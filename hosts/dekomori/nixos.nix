{pkgs, ...}: {
  yunfachi-nixos = {
    archisteamfarm.enable = true;
    grub.enable = false; # I am using SeaBIOS so grub loader is not needed
  };
}

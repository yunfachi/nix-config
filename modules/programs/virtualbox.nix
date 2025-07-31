{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.virtualbox";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.always = {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };

    user.extraGroups = ["vboxusers"];

    boot.kernelParams = ["kvm.enable_virt_at_load=0"];
  };
}

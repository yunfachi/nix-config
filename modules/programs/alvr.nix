{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.alvr";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.programs.alvr = {
    enable = true;
    openFirewall = true;
  };
}

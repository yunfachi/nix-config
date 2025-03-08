{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.bat";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batdiff prettybat];

    config = {
      style = "plain,changes";
    };
  };
}

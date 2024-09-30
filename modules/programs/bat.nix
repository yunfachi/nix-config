{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.bat";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batdiff prettybat];

    config = {
      style = "plain,changes";
    };
  };
}

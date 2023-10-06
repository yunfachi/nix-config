{
  pkgs,
  anyrun,
  ...
}: {
  imports = [
    anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        rink
        shell
        translate
      ];

      width.fraction = 0.3;
      y.absolute = 15;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
    '';
  };
}

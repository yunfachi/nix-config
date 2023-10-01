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
    };
    extraCss = ''

    '';
  };
}

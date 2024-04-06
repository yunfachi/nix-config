{
  module-functions,
  hm,
  pkgs,
  username,
  config,
  ...
}:
module-functions.module "programs" "wpaperd" (cfg: {
  hm.programs.wpaperd = {
    enable = true;

    settings = {
      default = {
        path = pkgs.symlinkJoin {
          name = "${username}-wallpapers";
          paths = builtins.map (wallpaper:
            pkgs.fetchurl {
              inherit (wallpaper) url hash;
              downloadToTemp = true;
              recursiveHash = true;
              postFetch = ''
                mkdir -p $out;
                filename=${builtins.baseNameOf wallpaper.url};
                mv file $out/$(printf `printf "${wallpaper.url}" | sha512sum`).''${filename##*.};
              '';
            })
          cfg.wallpapers;
        };
        duration = "5m";
      };
    };
  };

  yunfachi.commands.onGraphical.startup = [
    "${config.hm.programs.wpaperd.package}/bin/wpaperd"
  ];
})

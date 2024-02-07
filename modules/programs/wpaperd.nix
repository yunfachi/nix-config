{
  module-functions,
  hm,
  pkgs,
  username,
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
                mv file $out/$(echo $RANDOM | md5sum | head -c 30).''${filename##*.};
              '';
            })
          cfg.wallpapers;
        };
        duration = "5m";
      };
    };
  };
})

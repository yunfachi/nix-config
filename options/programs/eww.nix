{option-functions, ...}:
with option-functions;
  option "programs" "eww" (cfg: {
    enable = enableOption "eww" true;

    config = attrsOption "list of strings, yuck scripts that will be added to config" {} types.str;

    bar = {
      x = numberOption "x" 8; #TODO: use gaps_out from rice.nix
      y = numberOption "y" 8;
      width = numberOption "width" (1920 - cfg.bar.x * 2); #FIXME: I don't even know how to do this, probably a separate window for each monitor in eww
      height = numberOption "height" 24;
    };
  })

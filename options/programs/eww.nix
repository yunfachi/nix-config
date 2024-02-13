{
  option-functions,
  config,
  ...
}:
with option-functions;
  option "programs" "eww" (cfg: {
    enable = enableOption "eww" true;

    config = attrsOption "list of strings, yuck scripts that will be added to config" {} types.str;

    bar = {
      x = numberOption "x" config.yunfachi.rice.gaps.outer;
      y = numberOption "y" config.yunfachi.rice.gaps.outer;
      width = numberOption "width" (1920 - cfg.bar.x * 2); #FIXME: I don't even know how to do this, probably a separate window for each monitor in eww
      height = numberOption "height" 30;
    };
  })

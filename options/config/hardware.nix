{option-functions, ...}:
with option-functions;
  option null "hardware" (cfg: {
    displays = listOption "displays" {} (submoduleOption {
      enabled = enableOption "enabled" true;
      touchscreen = enableOption "touchscreen" false;

      id = textOption "id" null;
      primary = enableOption "primary" (
        if builtins.length cfg.displays == 1
        then true
        else false
      );

      width = numberOption "width" 1920;
      height = numberOption "height" 1080;
      x = numberOption "x" 0;
      y = numberOption "y" 0;

      refreshRate = numberOption "refresh rate" 60;
    });
  })

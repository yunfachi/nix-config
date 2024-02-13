{
  option-functions,
  config,
  nix-colors,
  options,
  ...
}:
with option-functions; let
  rice = cfg: {
    colorscheme = customOption config.yunfachi.colorschemes.coffee options.yunfachi.colorschemes.type.nestedTypes.elemType;

    border_size = numberOption "border size" 2;
    rounding = numberOption "rounding" 8;
    gaps = {
      inner = numberOption "gaps between windows (twice as large, since all windows have them)" 5;
      outer = numberOption "gaps between windows and monitor edges" (cfg.gaps.inner * 2);
    };
    bar_height = numberOption "height" 30;
  };

  riceModule = {name, ...}: {
    options = rice config.yunfachi.rices.${name};
  };
in {
  options.yunfachi = {
    rice = customOption config.yunfachi.rices.default (submoduleOption (rice config.yunfachi.rice));

    rices = attrsOption "rices" {
      default = {};
      test = {
        border_size = 1;
        rounding = 0;
      };
    } (submoduleOption riceModule);
  };
}

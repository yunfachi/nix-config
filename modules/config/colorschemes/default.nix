{
  delib,
  ylib,
  ...
}:
delib.module {
  name = "coloschemes";

  options = {myconfig, ...}:
    with delib; let
      colorscheme = {config, ...}: let
        colorOption = apply (noDefault (allowAttrs (strOption null))) (color:
          if builtins.typeOf color == "string"
          then ylib.color color
          else color);
        colorOptionWithDefault = default: colorOption // {inherit default;};

        base16Options = builtins.listToAttrs (
          map (hex: {
            name = "base${hex}";
            value = colorOption;
          })
          ["00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0A" "0B" "0C" "0D" "0E" "0F"]
        );

        # https://github.com/tinted-theming/base24/blob/master/styling.md#base24-fallbacks
        base24Options = {
          base10 = colorOptionWithDefault config.base00;
          base11 = colorOptionWithDefault config.base00;
          base12 = colorOptionWithDefault config.base08;
          base13 = colorOptionWithDefault config.base0A;
          base14 = colorOptionWithDefault config.base0B;
          base15 = colorOptionWithDefault config.base0C;
          base16 = colorOptionWithDefault config.base0D;
          base17 = colorOptionWithDefault config.base0E;
        };
      in {
        options =
          {
            polarity = noDefault (enumOption ["dark" "light"] null);
          }
          // base16Options
          // base24Options;
      };
    in {
      colorscheme = submoduleOption colorscheme myconfig.colorschemes.coffee;
      colorschemes = attrsOfOption (submodule colorscheme) {};
    };

  myconfig.always = {myconfig, ...}: {
    args.shared.colorscheme = myconfig.colorscheme;
  };
}

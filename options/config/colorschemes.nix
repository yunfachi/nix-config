{
  option-functions,
  module-functions,
  lib,
  ylib,
  ...
}:
with option-functions; let
  base16Ids = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F"];

  colorType = lib.mkOptionType {
    name = "color";
    check = color:
      lib.isAttrs color
      && color ? value
      && builtins.attrNames (ylib.color color.value) == builtins.attrNames color;
  };

  colorscheme = builtins.listToAttrs (builtins.map (id: {
      name = "base0${id}";
      value = customOption null colorType;
    })
    base16Ids);
in {
  options.yunfachi = with ylib; {
    colorschemes = attrsOption "colorschemes" {
      coffee = {
        base00 = color "#231F1E";
        base01 = color "#292423";
        base02 = color "#332927";
        base03 = color "#463A37";
        base04 = color "#564642";
        base05 = color "#9B8B88";
        base06 = color "#917E7A";
        base07 = color "#897C78";
        base08 = color "#F24343";
        base09 = color "#F7D979";
        base0A = color "#7E9E2D";
        base0B = color "#9DCC57";
        base0C = color "#3CEAA8";
        base0D = color "#6EDDD6";
        base0E = color "#9991F1";
        base0F = color "#E480AD";
      };
    } (submoduleOption colorscheme);
  };
}

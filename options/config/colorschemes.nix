{
  option-functions,
  lib,
  ...
}:
with option-functions; let
  colorscheme = builtins.listToAttrs (builtins.map (id: {
    name = "base0${toString id}";
    value = textOption "hex color" "ffffff";
  }) ((lib.range 0 9) ++ ["A" "B" "C" "D" "E" "F"]));
in {
  options.yunfachi = {
    colorschemes = attrsOption "colorschemes" {
      coffee = {
        base00 = "231F1E";
        base01 = "292423";
        base02 = "332927";
        base03 = "463A37";
        base04 = "564642";
        base05 = "9B8B88";
        base06 = "917E7A";
        base07 = "897C78";
        base08 = "F24343";
        base09 = "F7D979";
        base0A = "7E9E2D";
        base0B = "9DCC57";
        base0C = "3CEAA8";
        base0D = "6EDDD6";
        base0E = "9991F1";
        base0F = "E480AD";
      };
    } (submoduleOption colorscheme);
  };
}

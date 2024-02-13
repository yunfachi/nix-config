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
        base03 = "5B3F38";
        base04 = "564642";
        base05 = "9C8C89";
        base06 = "F09177";
        base07 = "42302C";
        base08 = "DEC36F";
        base09 = "F24343";
        base0A = "6E4A40";
        base0B = "9DCC57";
        base0C = "DE4040";
        base0D = "E480AD";
        base0E = "FEA677";
        base0F = "6E5E5B";
      };
    } (submoduleOption colorscheme);
  };
}

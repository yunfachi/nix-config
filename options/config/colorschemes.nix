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
      default = {};
    } (submoduleOption colorscheme);
  };
}

{
  delib,
  ylib,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.codium";

  home.ifEnabled = let
    theme = with colorscheme;
      ylib.vscodeBase24Theme {
        scheme-name = "";
        variant = polarity;
        inherit base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F base10 base11 base12 base13 base14 base15 base16 base17;
      };
  in {
    programs.vscode.extensions = [theme];
  };
}

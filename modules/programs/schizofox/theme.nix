{
  delib,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.schizofox";

  home.ifEnabled.programs.schizofox.theme.colors = with colorscheme; {
    background-darker = base10.value;
    background = base00.value;
    foreground = base07.value;
    primary = base02.value;
    border = "00000000";
  };
}

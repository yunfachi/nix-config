{
  delib,
  host,
  ...
}:
delib.module {
  name = "newt";

  options = delib.singleEnableOption host.cliFeatured;

  nixos.ifEnabled.environment.variables."NEWT_COLORS" = ''
    root=black,black;
    window=gray,gray;
    border=lightgray,gray;
    listbox=lightgray,gray;
    label=lightgray,gray;
    checkbox=green,black;
    title=green,gray;
    button=lightgray,green;
    actsellistbox=lightgray,green;
    actlistbox=lightgray,gray;
    compactbutton=lightgray,gray;
    actcheckbox=lightgray,blue;
    entry=lightgray,black;
    textbox=blue,black
  '';
}

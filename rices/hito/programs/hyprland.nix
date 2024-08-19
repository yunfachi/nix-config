{
  delib,
  colorscheme,
  ...
}:
delib.rice {
  name = "hito";

  myconfig.programs.hyprland = with colorscheme; {
    background_color = "rgb(${base11.value})";

    gaps = {
      inner = 6;
      outer = 12;
    };

    border = {
      size = 2;
      radius = 6;
      inactive_color = "rgba(${base02.value}ee)";
      active_color = "rgba(${base03.value}ff)";
    };
  };
}

{
  delib,
  colorscheme,
  ...
}:
delib.rice {
  name = "shikakui";

  myconfig.programs.hyprland = with colorscheme; {
    background_color = "rgb(${base11.value})";

    gaps = {
      inner = 6;
      outer = 12;
    };

    border = {
      size = 0;
      radius = 0;
      inactive_color = "rgba(${base02.value}ee)";
      active_color = "rgba(${base03.value}ff)";
    };
  };
}

{option-functions, ...}:
with option-functions;
  option null "commands" {
    onGraphical = {
      startup = listOption "shell scripts executed after loading the desktop" [] types.str;
      reload = listOption "shell scripts executed after reloading the desktop" [] types.str;
    };
  }

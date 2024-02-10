{option-functions, ...}:
with option-functions;
  option null "startup" {
    commands = {
      onGraphical = listOption "shell scripts executed after loading the desktop" [] types.str;
    };
  }

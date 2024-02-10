{
  option-functions,
  config,
  ...
}:
with option-functions;
  option "services" "hyprland" {
    enable = enableOption "hyprland" (config.host.window-manager == "hyprland");
    commands = {
      onStartup = listOption "shell scripts executed after loading the desktop" [] types.str;
      onReload = listOption "shell scripts executed after reloading the desktop" [] types.str;
    };
  }

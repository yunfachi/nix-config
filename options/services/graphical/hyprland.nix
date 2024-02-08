{
  option-functions,
  config,
  ...
}:
with option-functions;
  option "services" "hyprland" {
    enable = enableOption "hyprland" (config.host.window-manager == "hyprland");
    startupCommands = listOption "shell scripts executed after loading the hyprland" [] types.str;
  }

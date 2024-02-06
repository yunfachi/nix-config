{
  option-functions,
  config,
  ...
}:
with option-functions;
  option "services" "awesome" {
    enable = enableOption "awesome" (config.host.window-manager == "awesome");
  }

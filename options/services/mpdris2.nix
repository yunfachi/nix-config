{
  option-functions,
  config,
  ...
}:
with option-functions;
  option "services" "mpdris2" {
    enable = enableOption "mpdris2" config.yunfachi.services.mopidy.enable;
  }

{
  option-functions,
  host,
  config,
  ...
}:
with option-functions;
  option "services" "mopidy" {
    enable = enableOption "mopidy" host.isDesktop;
    media_dirs = listOption "media dirs" [] types.str;

    jellyfin = {
      enable = enableOption "mopidy extension for playing audio files from Jellyfin" config.yunfachi.services.jellyfin.enable;
      hostname = textOption "Jellyfin server hostname" "localhost:8096";
      username = textOption "Jellyfin username" null;
      user_id = textOption "Jellyfin user_id" null;
      token = textOption "Jellyfin token" null;
      libraries = listOption "Jellyfin libraries" [] types.str;
    };
  }

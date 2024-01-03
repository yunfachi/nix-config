{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    discord.enable = lib.mkEnableOption "discord" // {default = type == "desktop";};
    firefox.enable = lib.mkEnableOption "firefox" // {default = type == "desktop";};
    git.enable = lib.mkEnableOption "git" // {default = true;};
    steam.enable = lib.mkEnableOption "steam" // {default = type == "desktop";};
    hyprland.enable = lib.mkEnableOption "hyprland" // {default = type == "desktop";};
    kitty.enable = lib.mkEnableOption "kitty" // {default = type == "desktop";};
    shikimori.enable = lib.mkEnableOption "shikimori" // {default = type == "desktop";};
    telegram.enable = lib.mkEnableOption "telegram" // {default = type == "desktop";};
  };
}

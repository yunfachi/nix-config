{
  config,
  pkgs-yunfachi,
  ...
}: {
  #home.file.".config/yunfaAvatar/config.conf" = {
  #  source = config.age.secrets.yunfaavatar.path;
  #  recursive = true;
  #};
  home.packages = with pkgs-yunfachi; [
    yunfaavatar
  ];
}

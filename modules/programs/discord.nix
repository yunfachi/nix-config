{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.discord";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [".config/discordptb" ".config/Vencord"];

  home.ifEnabled.home.packages = [
    (pkgs.discord-ptb.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}

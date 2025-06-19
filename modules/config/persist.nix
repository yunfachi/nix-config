{
  delib,
  inputs,
  constants,
  homeconfig,
  ...
}:
delib.module {
  name = "persist";

  options.persist = with delib; {
    enable = boolOption false;
    persistPath = noDefault (strOption null);

    directories = listOption [];
    files = listOption [];

    user = {
      directories = listOption [];
      files = listOption [];
    };
  };

  nixos.always.imports = [inputs.impermanence.nixosModules.impermanence];

  nixos.ifEnabled = {cfg, ...}: {
    environment.persistence.${cfg.persistPath} = {
      enable = true;
      hideMounts = true;

      directories =
        [
          "/var/lib/nixos"
        ]
        ++ cfg.directories;
      files =
        [
          # TODO: set machine in host config
          "/etc/machine-id"
        ]
        ++ cfg.files;

      users.${constants.username} = {
        # https://github.com/nix-community/impermanence/blob/4b3e914cdf97a5b536a889e939fb2fd2b043a170/nixos.nix#L307
        #home = homeconfig.home.homeDirectory;

        directories =
          [
            "nix-config"
          ]
          ++ cfg.user.directories;

        files = cfg.user.files;
      };
    };
  };
}

{ delib, ypkgs, ... }:
delib.module {
  name = "programs.librewolf";

  options.programs.librewolf = with delib; {
    extensions = listOption [ ];
  };

  home.ifEnabled =
    { cfg, ... }:
    {
      programs.librewolf.profiles.default.extensions = {
        force = true;
        packages =
          with ypkgs.firefox-addons;
          [
            ublock-origin
            deshiro
            bitwarden-password-manager
            yomitan
            history-cleaner
            new-tab-homepage
          ]
          ++ cfg.extensions;
      };
    };
}

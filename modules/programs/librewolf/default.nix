{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.librewolf";

  options.programs.librewolf = with delib; {
    enable = boolOption host.guiFeatured;
  };

  myconfig.ifEnabled = {
    xdg.mime.recommended =
      let
        librewolf = "librewolf.desktop";
      in
      {
        "application/json" = [ librewolf ];
        "application/pdf" = [ librewolf ];
        "application/rdf+xml" = [ librewolf ];
        "application/rss+xml" = [ librewolf ];
        "application/x-extension-htm" = [ librewolf ];
        "application/x-extension-html" = [ librewolf ];
        "application/x-extension-shtml" = [ librewolf ];
        "application/x-extension-xht" = [ librewolf ];
        "application/x-extension-xhtml" = [ librewolf ];
        "application/xhtml_xml" = [ librewolf ];
        "application/xhtml+xml" = [ librewolf ];
        "application/xml" = [ librewolf ];
        "x-scheme-handler/about" = [ librewolf ];
        "x-scheme-handler/http" = [ librewolf ];
        "x-scheme-handler/https" = [ librewolf ];
        "x-scheme-handler/unknown" = [ librewolf ];
      };

    persist.user.directories = [ ".librewolf" ];
  };

  home.ifEnabled = {
    programs.librewolf = {
      enable = true;
    };
  };
}

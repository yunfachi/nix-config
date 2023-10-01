{pkgs, ...}: {
  programs = {
    google-chrome = {
      enable = true;
      commandLineArgs = [
        "--gtk-version=4"
      ];
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
  };
}

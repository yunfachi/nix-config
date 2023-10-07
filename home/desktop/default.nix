{pkgs, ...}: {
  imports = [
    ../core

    ./kitty.nix
    ./media.nix
    ./ssh.nix
    ./wallpaper.nix
    ./gaming.nix
    ./xdg.nix
    ./yunfaavatar.nix
  ];

  home.packages = with pkgs; [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    telegram-desktop

    spotify
    spicetify-cli
  ];

  programs.gh = {
    enable = true;
  };
}

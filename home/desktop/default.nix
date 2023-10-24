{pkgs, ...}: {
  imports = [
    ../core

    ./tools/bat.nix
    ./tools/kitty.nix
    ./tools/yunfaavatar.nix
    ./tools/fish.nix
    ./gaming.nix
    ./media.nix
    ./ssh.nix
    ./wallpaper.nix
    ./xdg.nix
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

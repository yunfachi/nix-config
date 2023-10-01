{pkgs, ...}: {
  imports = [
    ../core

    ./kitty.nix
    ./media.nix
    ./ssh.nix
    ./wallpaper.nix
    ./gaming.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    telegram-desktop
  ];

  programs.gh = {
    enable = true;
  };
}

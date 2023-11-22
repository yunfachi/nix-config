{
  lib,
  username,
  nixosVersion,
  ...
}: {
  imports = [
    ./core
  ];

  home = {
    username = username;
    homeDirectory = lib.mkForce "/home/${username}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = nixosVersion;
}

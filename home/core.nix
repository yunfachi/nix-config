{
  lib,
  username,
  nixosVersion,
  ...
}: {
  home = {
    username = username;
    homeDirectory = lib.mkForce "/home/${username}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = nixosVersion;
}

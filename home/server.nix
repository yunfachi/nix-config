{
  username,
  nixosVersion,
  ...
}: {
  imports = [
    ./core
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = nixosVersion;
}

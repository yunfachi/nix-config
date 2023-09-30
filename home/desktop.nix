{
  username,
  nixosVersion,
  ...
}: {
  imports = [
    ./desktop

    ./hyprland
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = nixosVersion;
}

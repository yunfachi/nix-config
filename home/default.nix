{
  umport,
  username,
  lib,
  ...
}: {
  imports =
    umport {
      path = ./.;
      exclude = [./programs];
    }
    ++ umport {path = ./programs;};

  home = {
    username = username;
    homeDirectory = lib.mkForce "/home/${username}";

    stateVersion = "24.05";
  };
}

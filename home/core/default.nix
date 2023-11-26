{
  lib,
  username,
  ...
}: {
  imports = map (n: toString ./. + "/${n}") (lib.remove "default.nix" (builtins.attrNames (builtins.readDir ./.)));

  home = with lib; {
    username = mkForce "${username}";
    homeDirectory = mkForce "/home/${username}";
    stateVersion = mkForce "23.11";
  };
}

{lib, ...}: {
  imports = map (n: toString ./. + "/${n}") (lib.remove "default.nix" (builtins.attrNames (builtins.readDir ./.)));

  networking = {
    hostName = "dekomori";
  };
}

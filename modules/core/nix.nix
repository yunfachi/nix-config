{
  inputs,
  pkgs,
  ...
}: {
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixVersions.unstable;
  };
}

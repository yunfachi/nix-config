{
  lib,
  umport,
  ...
}: {
  imports = umport {path = ./.;};

  networking = {
    hostName = "kyouko";
  };
}

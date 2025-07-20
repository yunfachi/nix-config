{delib, ...}:
delib.module {
  name = "hosts";

  nixos.always = {myconfig, ...}: {
    boot.kernelParams =
      map (
        display: with display; "video=${name}:${toString width}x${toString height}@${toString refreshRate}"
      )
      myconfig.host.displays;
  };
}

{ delib, ... }:
delib.module {
  name = "programs.uni-sync";

  options.programs.uni-sync = with delib; {
    enable = boolOption false;
    devices = listOfOption attrs [ ];
  };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      hardware.uni-sync = { inherit (cfg) enable devices; };
    };
}

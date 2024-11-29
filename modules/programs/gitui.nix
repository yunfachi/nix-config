{delib, ...}:
delib.module {
  name = "programs.gitui";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.gitui = {
    enable = true;
  };
}

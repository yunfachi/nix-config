{delib, ...}:
delib.module {
  name = "programs.bash";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.bash = {
    enable = true;

    historyControl = ["ignoredups" "ignorespace"];
  };
}

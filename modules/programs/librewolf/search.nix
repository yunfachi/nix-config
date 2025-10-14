{ delib, ... }:
delib.module {
  name = "programs.librewolf";

  home.ifEnabled.programs.librewolf.profiles.default.search = {
    force = true;
    default = "google";
  };
}

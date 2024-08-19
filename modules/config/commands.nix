{delib, ...}:
delib.module {
  name = "commands";

  # New options are added as needed
  options.commands = with delib; let
    option = listOfOption str [];
  in {
    windowManager = {
      onStartup = option;
      onReload = option;
    };
  };
}

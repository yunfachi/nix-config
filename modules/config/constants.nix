{delib, ...}:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "yunfachi");
    userfullname = readOnly (strOption "Yun Fachi");
    useremail = readOnly (strOption "yunfachi@gmail.com");
  };

  myconfig.always = {cfg, ...}: {
    args.shared.constants = cfg;
  };
}

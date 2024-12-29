{delib, ...}:
delib.host {
  name = "jakuzure";

  myconfig.programs.uni-sync = {
    enable = true;
    devices = [
      {
        device_id = "VID:3314/PID:41219/SN:6243168001";
        sync_rgb = true;
        channels =
          builtins.genList (_: {
            mode = "PWM";
            speed = 100;
          })
          4;
      }
    ];
  };
}

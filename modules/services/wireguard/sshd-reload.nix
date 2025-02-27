{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.wireguard";

  nixos.ifEnabled = {myconfig, ...}: {
    systemd.services.sshd-reload = lib.mkIf myconfig.services.sshd.enable {
      partOf = ["wg-quick-wg0.service"];
      wantedBy = ["wg-quick-wg0.service"];
      bindsTo = ["sshd.service"];
      after = ["sshd.service" "wg-quick-wg0.service"];

      script = ''
        kill -HUP $(cat /var/run/sshd.pid)
      '';

      serviceConfig.Type = "oneshot";
    };
  };
}

{delib, pkgs, lib, ...}:
delib.host {
  name = "jakuzure";

  nixos.systemd.services.kfrgb = {
    serviceConfig.ExecStart = pkgs.writeShellScript 
      "kfrgb.sh"
      "bash ${pkgs.fetchurl {
      url = "https://github.com/KeyofBlueS/kfrgb/raw/refs/heads/main/kfrgb.sh";
      name = "kfrgb.sh";
      executable = true;
      hash = "sha256-zbuADA+aBdELsJVUy2mks+UlTyz4Ocaukhddu+8GOkU=";
    }} --smbus 1 --ramslots 2,4 --mode static --color 60,12,253 --iwanttoriskandskipmodeldetectionevenifiknowthisisstronglynotrecommended --nowarn"
    ;
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [bash gawk i2c-tools yad perl lshw];
 };
}

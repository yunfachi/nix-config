{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages_latest.pm2
  ];

  systemd.services.pm2 = {
    enable = true;
    description = "pm2";
    unitConfig = {
      Type = "simple";
    };
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.nodePackages_latest.pm2}/bin/pm2 resurrect";
      ExecReload = "${pkgs.nodePackages_latest.pm2}/bin/pm2 reload all";
      ExecStop = "${pkgs.nodePackages_latest.pm2}/bin/pm2 kill";
    };
  };
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages_latest.pm2
  ];

  systemd.user.services."pm2" = {
    Unit.Description = "pm2";
    Unit.Type = "simple";
    Install.WantedBy = ["multi-user.target"];
    Service = {
      ExecStart = "${pkgs.nodePackages_latest.pm2}/bin/pm2 resurrect";
      ExecReload = "${pkgs.nodePackages_latest.pm2}/bin/pm2 reload all";
      ExecStop = "${pkgs.nodePackages_latest.pm2}/bin/pm2 kill";
    };
  };
}

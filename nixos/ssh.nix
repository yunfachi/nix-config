{
  config,
  lib,
  username,
  ...
}: let
  cfg = config.yunfachi.ssh;
in {
  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = lib.mkIf (cfg.type == "server") [22];

    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    users.users."${username}".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILG1KltBx01hsQ7/DhRkLGFCADAX7KIumiTkbnE71pi2"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGZ1/5LbS/pkJSkbP0YH6T3ArMXaEzXi67bCOVLE3bUL"
    ];
  };
}

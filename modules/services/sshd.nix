{
  delib,
  pkgs,
  user,
  constants,
  wireguardLocalAddress,
  ...
}:
delib.module {
  name = "services.sshd";

  options.services.sshd = with delib; {
    enable = boolOption true;

    ports = listOfOption port [22];
    listenAddresses =
      listOfOption str
      (
        if wireguardLocalAddress != null
        then [wireguardLocalAddress]
        else []
      );

    authorizedKeys = listOfOption str [];
  };

  myconfig.ifEnabled.persist.files = [
    "/etc/ssh/ssh_host_rsa_key"
    "/etc/ssh/ssh_host_rsa_key.pub"
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
  ];

  nixos.ifEnabled = {cfg, ...}: {
    user.openssh.authorizedKeys.keys = cfg.authorizedKeys;

    services = {
      openssh = {
        enable = true;

        listenAddresses = map (addr: {inherit addr;}) cfg.listenAddresses;
        # startWhenNeeded = true;

        settings = {
          PermitRootLogin = "no";

          ChallengeResponseAuthentication = "no";
          PasswordAuthentication = false;
          UsePAM = false;
          AuthenticationMethods = "publickey";
          PubkeyAuthentication = "yes";
          PermitEmptyPasswords = "no";
          KbdInteractiveAuthentication = false;

          ClientAliveCountMax = 5;
          ClientAliveInterval = 60;
          IgnoreRhosts = "yes";
          MaxAuthTries = 3;

          AllowUsers = [constants.username];
        };

        package = pkgs.openssh_hpn;
      };

      fail2ban.jails.sshd.settings = {
        enabled = true;
        filter = "sshd[mode=aggressive]";
        port = builtins.concatStringsSep "," (map toString cfg.ports);
      };
    };
  };
}

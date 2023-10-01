{pkgs, ...}: {
  programs.ssh = {
    enable = true;

    # ssh-keygen -t ed25519 -C "yunfachi@host"`
    extraConfig = ''
      AddKeysToAgent yes

      Host changelog yakudza asf jndi
        HostName 127.0.0.1
        Port 22

      Host db database dbs databases psql postgres postgresql mysql msql redis
        HostName 127.0.0.1
        Port 22
    '';
  };
}

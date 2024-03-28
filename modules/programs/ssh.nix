{
  module-functions,
  username,
  config,
  pkgs,
  lib,
  ...
}:
module-functions.module "programs" "ssh" {
  sops = {
    secrets = {
      "hosts/dekomori/ip" = {};
    };
    templates.".ssh/config" = {
      owner = "yunfachi";
      content = ''
        Host *
          AddKeysToAgent yes
          Port 22

        Host dekomori
          HostName ${config.sops.placeholder."hosts/dekomori/ip"}
          User ${username}
      '';
    };
  };

  environment.etc."ssh/ssh_config".source = lib.mkForce config.sops.templates.".ssh/config".path;
  programs.ssh = {
    package = pkgs.openssh_hpn;
  };
}

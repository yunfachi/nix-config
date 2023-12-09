{
  pkgs,
  sops,
  config,
  username,
  ...
}: {
  imports = [
    sops.sops
  ];

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFormat = "yaml";

    #defaultSopsFile = ./secrets.yaml;

    secrets = {
      /*
        secret = {
        format = "binary";
        mode = "400";
        sopsFile = ./config.secret;
        path = "/home/yunfachi/.config/secret/config.conf";
        owner = "${username}";
      };
      */
    };
  };
}

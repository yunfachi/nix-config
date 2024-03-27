{
  sops,
  username,
  ...
}: {
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = /home/${username}/.config/sops/age/keys.txt;
  };
}

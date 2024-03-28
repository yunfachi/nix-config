{
  ylib,
  username,
  ...
}: {
  decryptSecret = key:
    builtins.readFile (ylib.sops-decrypt {
      path = ../secrets.yaml;
      privateKeysFile = /home/${username}/.config/sops/age/keys.txt;
      inherit key;
    });
}

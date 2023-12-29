{
  host,
  secrets,
  ...
}: {
  yunfachi = {
    wireguard.clients."${host}" = {
      ip = "10.0.0.2";
      publicKey = secrets.yunfachi.wireguard.clients."${host}".publicKey;
    };
  };
}

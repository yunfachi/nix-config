{
  username,
  lib,
  ...
}: {
  imports = [
    (lib.mkAliasOptionModule ["user"] ["users" "users" username])
  ];

  users = {
    groups."${username}" = {};

    users."${username}" = {
      home = "/home/${username}";
      isNormalUser = true;
      initialPassword = "${username}";
      group = username;
      extraGroups = [
        "${username}"
        "users"
        "wheel"
      ];
    };
  };
}

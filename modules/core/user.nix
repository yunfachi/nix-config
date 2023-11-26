{username, ...}: {
  nix.settings.trusted-users = ["${username}"];
  users.groups."${username}" = {};
  users.users."${username}" = {
    # TODO: probably not needed
    #home = "/home/yunfachi";
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "${username}"
      "users"
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
    ];
  };
}

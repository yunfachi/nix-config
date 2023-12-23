{username, ...}: {
  nix.settings.trusted-users = ["${username}"];
  users.groups."${username}" = {};
  users.users."${username}" = {
    # TODO: probably not needed
    #home = "/home/${username}";
    isNormalUser = true;
    description = "${username}";
    initialPassword = "${username}";
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

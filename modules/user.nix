{username, ...}: {
  #=-=-=-=-=-=-#
  # User Stuff #
  #-=-=-=-=-=-=#
  nix.settings.trusted-users = [username];
  users.groups."${username}" = {};
  users.users."${username}" = {
    home = "/home/${username}";
    isNormalUser = true;
    description = username;
    extraGroups = [
      username
      "users"
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
    ];
  };
}

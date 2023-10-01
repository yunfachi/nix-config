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

  #=-=-=-=-=-=-#
  # Sudo Rules #
  #-=-=-=-=-=-=#
  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "/run/current-system/sw/bin/nix-store";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/nix-copy-closure";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}

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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOnc2cJelOlkRTL7pDs9ycFluDNv+IVFg42DHVQGv/Di yunfachi@mitama"
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

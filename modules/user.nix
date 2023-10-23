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
      # github
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINin10cad4eDG5u2W4ozQyZTINbjRLLnrFKo/WihL45r yunfachi@mitama"
      # servers
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELCGMGAQ6cGOLs1wsKFRYg5ECtvvAAmY1jasJdlRtHT yunfachi@mitama"
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

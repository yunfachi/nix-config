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
      # mitama ~ github
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINin10cad4eDG5u2W4ozQyZTINbjRLLnrFKo/WihL45r yunfachi@mitama"
      # yuki ~ servers
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELCGMGAQ6cGOLs1wsKFRYg5ECtvvAAmY1jasJdlRtHT yunfachi@mitama"
      # meido ~ secrets
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCrv1ypoRRd4O4BohV40yr2g55dHI2/+y3VXX/EH28k yunfachi@mitama"
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

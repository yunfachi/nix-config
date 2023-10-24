{
  config,
  pkgs,
  agenix,
  nix-secrets,
  username,
  ...
}: {
  imports = [
    agenix.nixosModules.default
  ];

  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  age.identityPaths = ["/home/${username}/.ssh/meido"];

  age.secrets = {
    "yunfaavatar" = {
      file = "${nix-secrets}/yunfaavatar.age";
      path = "/home/${username}/.config/yunfaAvatar/config.conf";
      mode = "644";
      owner = username;
    };
  };
}

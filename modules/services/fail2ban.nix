{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "services.fail2ban";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.persist.directories = ["/var/lib/fail2ban" "/var/log/fail2ban"];

  # https://github.com/NotAShelf/nyx/blob/main/modules/core/common/system/os/networking/firewall/fail2ban.nix
  nixos.ifEnabled.services.fail2ban = {
    enable = true;
    extraPackages = with pkgs; [nftables ipset];

    # I don't see the point in not checking local hosts if most of my services run through WireGuard
    ignoreIP = [
      # "127.0.0.0/8"
      # "10.0.0.0/8"
      # "192.168.0.0/16"
    ];

    banaction = "nftables-multiport";
    banaction-allports = lib.mkDefault "nftables-allport";

    maxretry = 4;
    bantime = "1h";
    bantime-increment = {
      enable = true;
      rndtime = "1h";
      overalljails = true;
      multipliers = "4 8 16 32 64 128 256 512 1024 2048";
    };
  };
}

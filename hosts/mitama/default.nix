{
  config,
  nixosVersion,
  ...
} @ args: {
  imports = [
    ./hardware.nix

    ../../modules/desktop.nix
    ../../modules/user.nix

    ../../secrets
  ];

  boot = {
    #    supportedFilesystems = [
    #      "ext4"
    #      "btrfs"
    #      "xfs"
    #      "ntfs"
    #      "fat"
    #      "vfat"
    #      "exfat"
    #    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = true;
    };
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  networking = {
    hostName = "mitama";

    proxy = {
      #default = "http://1.1.1.1:443";
      #noProxy = "127.0.0.1,localhost,internal.domain";
    };

    wireless.enable = false;
    networkmanager.enable = true;

    enableIPv6 = false;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  system.stateVersion = nixosVersion;
}

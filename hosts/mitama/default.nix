{
  config,
  nixosVersion,
  ...
} @ args: {
  imports = [
    ./hardware.nix

    ../../modules/desktop.nix
    ../../modules/user.nix

    #    ../../secrets
  ];

  #  nixpkgs.overlays = import ../../overlays args;

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
        #        efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = true;
    };
  };

  networking = {
    hostName = "mitama";

    proxy = {
      #default = "";
      #noProxy = "127.0.0.1,localhost,internal.domain";
    };

    wireless.enable = false;
    networkmanager.enable = true;

    enableIPv6 = false;
    defaultGateway = "192.168.110.201";
    interfaces.enp8s0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.110.100";
          prefixLength = 24;
        }
      ];
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  system.stateVersion = nixosVersion;
}

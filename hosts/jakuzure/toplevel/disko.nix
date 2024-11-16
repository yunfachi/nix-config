{
  delib,
  pkgs,
  ...
}:
delib.host {
  name = "jakuzure";

  myconfig.disko = {
    enable = true;

    configuration.devices = {
      disk = {
        samsung_980_pro_2tb = {
          type = "disk";
          device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S69ENF0WB26448L";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "4G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["defaults" "umask=0077"];
                };
              };
              zroot = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };

        adata_sx6000lnp = {
          type = "disk";
          device = "/dev/disk/by-id/nvme-ADATA_SX6000LNP_2L31291Q4HGH";
          content = {
            type = "gpt";
            partitions = {
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/media";
                };
              };
            };
          };
        };
      };

      zpool.zroot = {
        type = "zpool";
        mountpoint = null;

        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "lz4";
          mountpoint = "none";
          xattr = "sa";

          #encryption = "aes-256-gcm";
          #keyformat = "passphrase";
          #keylocation = "file:///tmp/secret.key";
          #keylocation = "promt";
        };

        options = {
          ashift = "12";
        };

        datasets = {
          "local/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
            postCreateHook = "zfs snapshot zroot/local/root@blank";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "legacy";
          };
          #TODO: "safe/persist/cache", "safe/persist/downloaded", "safe/persist/data", etc
          "safe/persist" = {
            type = "zfs_fs";
            mountpoint = "/persist";
            options.mountpoint = "legacy";
          };
        };
      };
    };
  };

  nixos = {
    boot.initrd.systemd = {
      #TODO: move boot.initrd.systemd .enable to modules/toplevel/boot
      enable = true;

      #TODO: optimize
      services.rollback-zroot-local-root = {
        after = ["zfs-import-zroot.service"];
        wantedBy = [
          "zfs.target"
          "initrd.target"
        ];
        before = ["sysroot.mount"];

        path = [pkgs.zfs];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          zfs rollback -r zroot/local/root@blank && echo "  >> >> rollback complete << <<"
        '';
      };
    };

    #FIXME: do something with this lol
    boot.supportedFilesystems = ["zfs"];
    boot.loader.grub.zfsSupport = true;
    boot.initrd.supportedFilesystems = ["zfs"];

    #FIXME: with this too
    networking.hostId = "71d5109b";
  };
}

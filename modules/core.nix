{
  lib,
  nixosVersion,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./user.nix
  ];

  nixpkgs.config.allowUnfree = lib.mkDefault true;
  nixpkgs.config.allowUnfreePredicate = lib.mkDefault (pkg: true);

  # Automatically optimize older generations of systems
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "daily";
    options = lib.mkDefault "--delete-older-than 1d";
  };

  boot = {
    # Disable boot menu
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = lib.mkDefault 1;
    loader.timeout = 0;
    loader.grub.enable = false;
    # Optimisations
    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];

  time.timeZone = "Europe/Madagascar";
  environment.variables.TZ = config.time.timeZone;
  i18n = let
    locale = "en_US.UTF-8";
    extraLocale = "ja_JP.UTF-8";
  in {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = extraLocale;
      LC_IDENTIFICATION = extraLocale;
      LC_MEASUREMENT = extraLocale;
      LC_MONETARY = extraLocale;
      LC_NAME = extraLocale;
      LC_NUMERIC = extraLocale;
      LC_PAPER = extraLocale;
      LC_TELEPHONE = extraLocale;
      LC_TIME = extraLocale;
    };
  };

  documentation = {
    enable = lib.mkDefault false;
    doc.enable = lib.mkDefault false;
    info.enable = lib.mkDefault false;
    man.enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };

  system.stateVersion = nixosVersion;
}

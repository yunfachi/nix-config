{
  lib,
  config,
  pkgs,
  ...
}: {
  #=-=-=-=#
  # Stuff #
  #-=-=-=-#
  nixpkgs.config.allowUnfree = lib.mkDefault false;
  networking.firewall.enable = lib.mkDefault false;
  nix.settings = {
    builders-use-substitutes = true;
    experimental-features = ["nix-command" "flakes"];
  };

  #=-=-=-=-=-=-=-#
  # Optimization #
  #-=-=-=-=-=-=-=#
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  #=-=-=-=-=-=-=-#
  # Localization #
  #-=-=-=-=-=-=-=#
  time.timeZone = "Europe/Moscow";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = let
      locale = "ja_JP.UTF-8";
    in {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  #=-=-=-=-=#
  # OpenSSH #
  #-=-=-=-=-#
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  #=-=-=-=-=-=-=-=-=-#
  # Default Packages #
  #-=-=-=-=-=-=-=-=-=#
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];

  #=-=-=-=-=-=-=-=-=-=-=-=#
  # Environment Variables #
  #-=-=-=-=-=-=-=-=-=-=-=-#
  environment.variables = {
    TZ = "${config.time.timeZone}";
  };
}

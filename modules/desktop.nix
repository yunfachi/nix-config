{
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./core.nix
  ];

  #=-=-=-=#
  # Stuff #
  #-=-=-=-#
  nixpkgs.config.allowUnfree = lib.mkForce true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  #=-=-=-=-#
  # Sounds #
  #-=-=-=-=#
  services.pipewire = {
    enable = true;
    package = pkgs-unstable.pipewire;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  #=-=-=-=-=-=-#
  # XDG Portal #
  #-=-=-=-=-=-=#
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      #xdg-desktop-portal-hyprland will be enabled in the hyprland module
    ];
  };

  #=-=-=-=#
  # Fonts #
  #-=-=-=-#
  # https://github.com/ryan4yin/nix-config/blob/a378fa3d60536f21fae9c58a834ca1f634aca020/modules/nixos/core-desktop.nix#L153C3-L153C3
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      material-design-icons
      font-awesome

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  #=-=-=-=-#
  # Shells #
  #-=-=-=-=#
  environment.shells = with pkgs; [
    bash
    fish
  ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}

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

  #=-=-=-=-#
  # Shells #
  #-=-=-=-=#
  environment.shells = with pkgs; [
    bash
    zsh
  ];
  users.defaultUserShell = pkgs.zsh;
  # idk why...
  programs.zsh.enable = true;
}

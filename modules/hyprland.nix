{
  pkgs,
  pkgs-unstable,
  hyprland,
  ...
}: {
  #=-=-=-=-=-=-=-=#
  # Login Manager #
  #-=-=-=-=-=-=-=-#
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "yunfachi";
      };
      default_session = initial_session;
    };
  };

  #=-=-=-=-=-#
  # Hyprland #
  #-=-=-=-=-=#
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    enableNvidiaPatches = false;
  };

  #=-=-=-=-=-=-#
  # XDG Portal #
  #-=-=-=-=-=-=#
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  #=-=-=-=#
  # Stuff #
  #-=-=-=-#
  environment.pathsToLink = ["/libexec"];
  security.pam.services.swaylock = {};
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;

      displayManager = {
        defaultSession = "hyprland";
        lightdm.enable = false;
      };
    };
  };

  #=-=-=-=-=-#
  # Programs #
  #-=-=-=-=-=#
  programs = {
    light.enable = true;
    thunar.plugins = with pkgs-unstable.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  environment.systemPackages = [
    pkgs-unstable.waybar # Status Bar
    pkgs-unstable.mako # Notification Daemon
    pkgs-unstable.swww # Wallpaper Daemon

    pkgs-unstable.wl-screenrec # Screen Recording
    pkgs-unstable.grimblast # Screenshots
    pkgs-unstable.yad # Dialogs

    pkgs-unstable.wlogout # Logout Menu
    pkgs-unstable.swayidle # Idle Daemon
    pkgs-unstable.swaylock-effects # Locker

    pkgs-unstable.wl-clipboard # Clipboard Utilities
    pkgs-unstable.cliphist # Clipboard Manager

    pkgs-unstable.xfce.thunar # File Manager
  ];
}

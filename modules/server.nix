{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./core.nix
  ];

  # Sometimes we need to run Python as root.
  environment.systemPackages = with pkgs; [
    python310
  ];

  # We don't need any of the X11 libraries on a server.
  environment.noXlibs = mkDefault true;

  # Because Perl is a default package, we need to remove it.
  environment.defaultPackages = mkDefault [];
  programs.less.lessopen = mkDefault null;
  boot.enableContainers = mkDefault false;

  programs.command-not-found.enable = mkDefault false;

  services.logrotate.enable = mkDefault false;
  services.udisks2.enable = mkDefault false;

  # No need for xdg on a server.
  xdg.autostart.enable = mkDefault false;
  xdg.icons.enable = mkDefault false;
  xdg.mime.enable = mkDefault false;
  xdg.sounds.enable = mkDefault false;

  # No need for fonts on a server.
  fonts.fontconfig.enable = lib.mkDefault false;

  # Print the URL instead of opening it in a browser.
  environment.variables.BROWSER = "echo";

  systemd = {
    enableEmergencyMode = lib.mkDefault false;

    sleep.extraConfig = ''
      # Disable sleep mode.
      AllowSuspend=no
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=no
    '';
  };
}

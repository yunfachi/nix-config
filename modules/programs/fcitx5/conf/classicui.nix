{delib, ...}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.xdg.configFile."fcitx5/conf/classicui.conf" = {
    force = true;
    text = ''
      # Vertical Candidate List
      Vertical Candidate List=False
      # Use mouse wheel to go to prev or next page
      WheelForPaging=True
      # Font
      Font="Sans 10"
      # Menu Font
      MenuFont="Sans 10"
      # Tray Font
      TrayFont="Sans Bold 10"
      # Tray Label Outline Color
      TrayOutlineColor=#000000
      # Tray Label Text Color
      TrayTextColor=#ffffff
      # Prefer Text Icon
      PreferTextIcon=False
      # Show Layout Name In Icon
      ShowLayoutNameInIcon=True
      # Use input method language to display text
      UseInputMethodLanguageToDisplayText=True
      # Theme
      Theme=nix-colorscheme
      # Dark Theme
      DarkTheme=nix-colorscheme
      # Follow system light/dark color scheme
      UseDarkTheme=False
      # Follow system accent color if it is supported by theme and desktop
      UseAccentColor=True
      # Use Per Screen DPI on X11
      PerScreenDPI=False
      # Force font DPI on Wayland
      ForceWaylandDPI=0
      # Enable fractional scale under Wayland
      EnableFractionalScale=True
    '';
  };
}

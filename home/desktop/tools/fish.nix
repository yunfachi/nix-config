{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs.fishPlugins; [
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      thefuck --alias | source
    '';
  };
}

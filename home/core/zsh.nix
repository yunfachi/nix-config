{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zsh-autocomplete
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
    };

    history = {
      path = "${config.xdg.dataHome}/.histfile";
      size = 10000;
      save = 10000;
    };
  };
}

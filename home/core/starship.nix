{...}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = "";
        style = "bold yellow";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style)";
        trim_at = "-";
        style = "bold dimmed white";
        disabled = true;
      };
    };
  };
}

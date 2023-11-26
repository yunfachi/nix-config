{lib, ...}: {
  # Disable documentation generation
  documentation = with lib; {
    enable = mkForce false;
    doc.enable = mkForce false;
    info.enable = mkForce false;
    man.enable = mkForce false;
    nixos.enable = mkForce false;
  };

  nix = {
    # Automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy
    settings.auto-optimise-store = true;

    optimise = {
      # Automatically run the nix store optimiser at a specific time
      automatic = true;
      dates = ["10:00"];
    };

    gc = {
      # Automatically run the nix garbage collector at a specific time
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}

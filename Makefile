hyprland:
	nixos-rebuils --switch --flake .#mitama_hyprland

format:
	alejandra ~/nix-config

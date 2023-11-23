HOST=$(shell hostname)
.MAIN: switch
.DEFAULT_GOAL: switch

#=-=-=-=-#
# Switch #
#-=-=-=-=#
switch:
	nixos-rebuild switch --flake .#$(HOST) --use-remote-sudo

#=-=-=-=#
# Hosts #
#-=-=-=-#
dekomori:
	nixos-rebuild switch --flake .#dekomori --use-remote-sudo
mitama:
	nixos-rebuild switch --flake .#mitama --use-remote-sudo

#=-=-=-=-#
# Update #
#-=-=-=-=#
up:
	nix flake update
upp:
	nix flake lock --update-input $(i)

#=-=-=-=#
# Stuff #
#-=-=-=-#
format:
	alejandra ./
history:
	nix profile history --profile /nix/var/nix/profiles/system
gc:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
	sudo nix store gc --debug
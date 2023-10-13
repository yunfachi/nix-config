HOST=$(shell hostname)
.MAIN: switch
.DEFAULT_GOAL: switch

#=-=-=-=#
# Hosts #
#-=-=-=-#
switch:
	sudo nixos-rebuild switch --flake .#$(HOST)
mitama:
	sudo nixos-rebuild switch --flake .#mitama

#=-=-=-=-#
# Update #
#-=-=-=-=#
up:
	sudo nix flake update
upp:
	sudo nix flake lock --update-input $(i)

#=-=-=-=#
# Stuff #
#-=-=-=-#
format:
	alejandra ~/nix-config
history:
	nix profile history --profile /nix/var/nix/profiles/system
gc:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
	sudo nix store gc --debug

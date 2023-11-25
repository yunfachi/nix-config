HOST=$(shell hostname)
.MAIN: switch
.DEFAULT_GOAL: switch

define rebuild
	@if [ "$(HOST)" == "$(1)" ] || [ "$(force)" == "1" ]; then \
		nixos-rebuild switch --flake .#$(1) --use-remote-sudo;\
	else\
		printf "You are trying to switch to a host different from the current one, which can lead to system failure.\n";\
		printf "If you are confident in your actions, then specify \e[32;1mforce=1\e[0m in the options.";\
	fi
endef

#=-=-=-=-#
# Switch #
#-=-=-=-=#
switch:
	@$(call rebuild,$(HOST))

#=-=-=-=#
# Hosts #
#-=-=-=-#
dekomori:
	@$(call rebuild,dekomori)
mitama:
	@$(call rebuild,mitama)

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
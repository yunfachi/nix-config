{
  description = "Modular configuration of NixOS and Home Manager with Denix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anime-launcher = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-config-wallpapers.url = "github:yunfachi/nix-config-wallpapers";
    wallpaper-manager = {
      url = "github:yunfachi/wallpaper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    denix,
    nixpkgs,
    ...
  } @ inputs: let
    mkConfigurations = moduleSystem:
      denix.lib.configurations rec {
        inherit moduleSystem;
        homeManagerUser = "yunfachi";

        paths = [
          ./hosts
          ./modules
          ./rices
        ];

        extensions = with denix.lib.extensions; [
          args
          (base.withConfig {
            args.enable = true;

            hosts.features = {
              # cli: not must-have (ssh, git, gpg, fail2ban, dnscrypt) utilities like eza, bat, nh, etc.
              # gui: gui applications and modules that are needed only for gui applications (gnome-keyring, wakatime)
              features = [
                "cli"
                "gui"
                "gaming"
                "hacking"
                "powersave"
                "wireless"
              ];
              defaultByHostType = {
                desktop = [
                  "cli"
                  "gui"
                  "gaming"
                  "hacking"
                ];
                server = [];
              };
            };
          })
        ];

        specialArgs = {
          inherit inputs moduleSystem homeManagerUser;
        };
      };
  in {
    nixosConfigurations = mkConfigurations "nixos";
    homeConfigurations = mkConfigurations "home";
  };
}

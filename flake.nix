{
  description = "Modular configuration of NixOS and Home Manager with Denix";

  outputs =
    { denix, nixpkgs, ... }@inputs:
    let
      mkConfigurations =
        moduleSystem:
        denix.lib.configurations rec {
          inherit moduleSystem;
          homeManagerUser = "yunfachi";

          paths = [
            ./hosts
            ./modules
            ./rices
          ];

          extensions = with denix.lib.extensions; [
            #rices
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
                  server = [ ];
                };
              };
            })
          ];

          specialArgs = { inherit inputs moduleSystem; };
        };
    in
    {
      nixosConfigurations = mkConfigurations "nixos";
      homeConfigurations = mkConfigurations "home";

      devShells.x86_64-linux = {
        hacking = nixpkgs.legacyPackages.x86_64-linux.mkShell {
          name = "hacking";
          packages = with nixpkgs.legacyPackages.x86_64-linux; [
            # Recon
            assetfinder
            nmap
            python313Packages.dirsearch
            # Reverse
            binwalk
            foremost
          ];
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixowos = {
      url = "github:yunfachi/NixOwOS";
      inputs.denix.follows = "denix";
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
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    burpsuitepro = {
      url = "github:xiv3r/Burpsuite-Professional";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-config-wallpapers.url = "github:yunfachi/nix-config-wallpapers";
    wallpaper-manager = {
      url = "github:yunfachi/wallpaper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

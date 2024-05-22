{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nypkgs = {
      url = "github:yunfachi/nypkgs/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anime-launcher = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nypkgs,
    nix-vscode-extensions,
    sops-nix,
    ...
  } @ inputs: let
    constants = import ./constants.nix;
    system = "x86_64-linux";
    data = import ./data {inherit (nixpkgs) lib;};

    packages = rec {
      ypkgs = nypkgs.legacyPackages.${system};
      ylib = ypkgs.lib;

      vscode-extensions = nix-vscode-extensions.extensions.${system}.vscode-marketplace;
    };

    lib =
      import ./lib/lib.nix {
        inherit (packages) ylib;
        inherit (constants) username;
      }
      // {
        module-functions = config:
          import ./lib/module-functions.nix {
            inherit (nixpkgs) lib;
            inherit (constants) username;
            inherit config;
          };
        option-functions = config:
          import ./lib/option-functions.nix {
            inherit (nixpkgs) lib;
            inherit (constants) username;
            inherit config;
          };
      };

    specialArgs =
      {
        inherit system data inputs;
      }
      // constants
      // packages
      // lib;
  in {
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit (packages) ylib;
      inherit (self) nixosConfigurations;
      inherit home-manager nypkgs sops-nix;
      inherit specialArgs;
    };

    devShells.${system}.default = with nixpkgs.legacyPackages.${system};
      mkShell {
        packages = [
          git
          statix
          deadnix
        ];
      };

    packages.${system} = with nixpkgs.legacyPackages.${system}; {
      prefetch-wallpapers = let
        script = writeShellScriptBin "prefetch-wallpapers" (builtins.readFile ./scripts/prefetch-wallpapers.sh);
        buildInputs = [nix-prefetch];
      in
        symlinkJoin {
          name = "prefetch-wallpapers";
          paths = [script] ++ buildInputs;
          buildInputs = [makeWrapper];
          postBuild = "wrapProgram $out/bin/prefetch-wallpapers --prefix PATH : $out/bin";
        };
      wireguard-configurations = let
        generateConfiguration = {
          client,
          privateKey,
          qr_code ? false,
        }: let
          cfg = self.nixosConfigurations.mitama.config.yunfachi.services.wireguard;
        in
          stdenv.mkDerivation {
            name = "wg-conf";

            src = writeTextDir "wg0.conf" ''
              [Interface]
              Address = ${cfg.clients.${client}.ip}
              PrivateKey = ${privateKey}

              [Peer]
              PublicKey = ${cfg.server.publicKey}
              Endpoint = ${cfg.server.ip}:${toString cfg.server.port}
              PersistentKeepalive = 20
              AllowedIPs = ${builtins.concatStringsSep "," cfg.routedIPs}
            '';

            buildInputs = [qrencode];
            buildPhase =
              if qr_code
              then ''
                qrencode -t ansiutf8 wg0.conf
                qrencode -t png -o wg0.png -r wg0.conf
              ''
              else "";

            installPhase = ''
              mkdir -p $out
              mv * $out
            '';
          };
      in {
        a52 = generateConfiguration {
          client = "a52";
          privateKey = lib.decryptSecret "wireguard/clients/a52/privateKey";
          qr_code = true;
        };
        p11 = generateConfiguration {
          client = "p11";
          privateKey = lib.decryptSecret "wireguard/clients/p11/privateKey";
          qr_code = true;
        };
      };
    };
  };
}

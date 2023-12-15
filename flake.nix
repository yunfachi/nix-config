{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixpkgs-yunfachi = {
      url = "github:yunfachi/nixpkgs-yunfachi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-yunfachi,
    ...
  }: let
    username = "yunfachi";
    userfullname = "yunfachi";
    useremail = "yunfachi@gmail.com";

    system = "x86_64-linux";

    specialArgs = rec {
      inherit inputs;
      inherit username userfullname useremail;
      inherit system;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-yunfachi = import nixpkgs-yunfachi {inherit nixpkgs system;};

      umport = pkgs-yunfachi.umport;
    };
  in {
    nixosConfigurations = import ./hosts (
      {inherit specialArgs;} // {isNixOS = true;}
    );

    homeConfigurations = import ./hosts (
      {inherit specialArgs;} // {isNixOS = false;}
    );
  };
}

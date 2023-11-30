{
  description = "yunfachi's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    username = "yunfachi";
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
      inherit username system;
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

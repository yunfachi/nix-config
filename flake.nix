{
  description = "yunfachi's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-yunfachi = {
      url = "github:yunfachi/nixpkgs-yunfachi/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    nixpkgs-yunfachi,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    username = "yunfachi";
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
      inherit username system;
      pkgs-yunfachi = import nixpkgs-yunfachi {inherit nixpkgs system;};
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

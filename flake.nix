{
  description = "Swag flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ...} @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      specialArgs = { inherit inputs; };
    in {
      nixosConfigurations.mefi = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
        disko.nixosModules.disko
        ./disko.nix
        ./configuration.nix
      ];
    };
  };
}

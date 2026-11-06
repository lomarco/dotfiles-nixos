{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    waterfox = {
      url = "github:Hythera/nix-waterfox";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      waterfox,
      nixos-facter-modules,
      ...
    }:
    let
      host = "mefi";
    in
    {
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit waterfox;
        };

        modules = [
          ./${host}
          disko.nixosModules.disko
          nixos-facter-modules.nixosModules.facter
          {
            config.facter.reportPath = ./facter.json;
          }
        ];
      };
    };
}

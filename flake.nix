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
  };

  outputs =
    {
      nixpkgs,
      disko,
      waterfox,
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
        ];
      };
    };
}

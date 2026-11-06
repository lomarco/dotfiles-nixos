{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    waterfox.url = "github:Hythera/nix-waterfox";

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
      system = "x86_64-linux";
      host = "mefi";
    in
    {
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./${host}
          disko.nixosModules.disko
          waterfox.packages.x86_64-linux.waterfox-bin
        ];
      };
    };
}

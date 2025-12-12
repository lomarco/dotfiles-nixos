{
  description = "Modern NixOS configuration with disko and flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    nix.url = "github:NixOS/nix";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = { flake-parts, systems, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      
      perSystem = { config, self', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixpkgs-fmt
            nil
            nixd
          ];
        };
      };

      flake = {
        nixosConfigurations = {
          "mefi" = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            
            modules = [
              {
                nix.settings = {
                  experimental-features = [ "nix-command" "flakes" ];
                  auto-optimise-store = true;
                };
                
                nix.registry.nixpkgs.flake = inputs.nixpkgs;
                nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
              }
              
              ./hardware-configuration.nix
              ./configuration.nix
            ];
          };
        };
      };
    };
}

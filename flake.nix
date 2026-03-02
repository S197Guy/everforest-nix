{
  description = "Everforest Niri NixOS Configuration (Melded)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations."scarr-one" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/scarr-one/configuration.nix
        
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.neonscar = {
            imports = [
              ./home/home.nix
              # removed redundant niri.homeModules.niri import
            ];
          };
        }

        inputs.niri.nixosModules.niri
      ];
    };
  };
}

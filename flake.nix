{
  description = "I'm all jacked up on Mt. Dew";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, sddm-sugar-candy-nix, ...}: 
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      TheTrap = lib.nixosSystem {
        inherit system;
        modules = [ 
          sddm-sugar-candy-nix.nixosModules.default
          {
            nixpkgs = {
              overlays = [
                sddm-sugar-candy-nix.overlays.default
              ];
            };
          }
          ./hosts/TheTrap/configuration.nix 
        ];
      };
    };
    homeConfigurations = {
     gitmoney = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./hosts/TheTrap/home.nix ];
     };
    };
  };
}

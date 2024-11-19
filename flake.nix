{
  description = "I'm all jacked up on Mt. Dew";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ...}: 
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      TheTrap = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/TheTrap/configuration.nix ];
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

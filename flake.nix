{
  description = "base configuration";

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
      main =lib.nixosSystem {
        inherit system;
        modules = [ ./main/configuration.nix ];
      };
    };
    homeConfigurations = {
     gitmoney = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./main/home.nix ];
     };
    };
  };
}

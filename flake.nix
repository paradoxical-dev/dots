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

    # TEST PATCH
    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.url = "path:/home/gitmoney/HyprPanel";
  };

  outputs = {self, nixpkgs, home-manager, hyprpanel, sddm-sugar-candy-nix, ...}: 
  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "TheTrap";
      timezone = "America/Chicago";
      locale = "en_US.UTF-8";
      keyLayout = "us";
      bootmode = "uefi";
      bootMountPath = "/boot";
      grubDevice = "";
      gpuType = "hybrid";
    };
    userSettings = {
      username = "gitmoney";
      name = "gitmoney";
      email = "jaredonnell21@gmail.com";
      theme = "yin";
      wm = "hyprland";
      wmType = "wayland";
      browser = "firefox";
      terminal = "kitty";
      shell = "zsh";
      editor = "nvim";
      fonts = [ pkgs.victor-mono ];
      nerdFonts = [ "JetBrainsMono" ];
      fontSize = "13";
    };
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {
    nixosConfigurations = {
      main = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ 
          ./hosts/${systemSettings.hostname}/configuration.nix 

          # sugar-candy overlay
          sddm-sugar-candy-nix.nixosModules.default
          {
            nixpkgs.overlays = [
              sddm-sugar-candy-nix.overlays.default
            ];
          }
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./hosts/${systemSettings.hostname}/home.nix
      ];
      extraSpecialArgs = {
        inherit systemSettings;
        inherit userSettings;
        inherit hyprpanel;
      };
     };
    };
  };
}

{
  description = "I'm all jacked up on Mt. Dew";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel, sddm-sugar-candy-nix, grub2-themes, ... }:
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
        gpu = {
          type = "hybrid";
          hybrid = {
            iGpuType = "amd";
            # BusIDs can be found with `lspci -nn | grep -i vga | grep -i <gpu type>`
            # The ID will be returned as "06:00.0" but must be formatted to remove trailing 0s and prefixed with "PCI:"
            iGpuBusId = "PCI:0:6:0";
            dGpuBusID = "PCI:0:1:0";
            # The primaryCard will be the linked card to the preferred GPU (typically the intrgrated GPU)
            # The card can be found by using `ls -l /dev/dri/by-path/` and finding the corresponding card number
            primaryCard = "card2";
          };
        };
      };
      userSettings = {
        username = "gitmoney";
        name = "gitmoney";
        email = "jaredonnell21@gmail.com";
        theme = "burst"; # yin | yang | burst
        wm = "hyprland";
        hypr = {
          # hyprland specific settings
          monitors = [ "eDP-2" ]; # can be found with `hyprctl monitors`
        };
        wmType = "wayland";
        browser = "firefox";
        terminal = "kitty";
        shell = "zsh";
        nvim = {
          nvim_compile = true; # To use compiled colorschemes using color-compiler.nvim
          match_theme = true; # whether to use colors.nix located in system/pkgs/nvim
        };
        fonts = [ pkgs.victor-mono ];
        nerdFonts = [ pkgs.nerd-fonts.jetbrains-mono ];
        fontSize = "11.5";
      };
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in
    {
      nixosConfigurations = {
        main = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/${systemSettings.hostname}/configuration.nix
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit grub2-themes;
            inherit sddm-sugar-candy-nix;
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

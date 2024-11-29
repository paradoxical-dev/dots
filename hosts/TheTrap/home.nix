{ config, pkgs, userSettings, hyprpanel, ... }:
{
    home.stateVersion = "24.05";
    home.username = userSettings.username;
    home.homeDirectory = "/home/" + userSettings.username + "/";

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ hyprpanel.overlay ];

    imports = [
     ../../user/shell/${userSettings.shell}.nix
     ../../user/shell/cli/fastfetch/fastfetch.nix
     ../../system/pkgs/tmux/${userSettings.theme}.nix

     ../../user/pkgs/zathura/${userSettings.theme}.nix
     ../../user/pkgs/kitty/${userSettings.theme}.nix
     ../../user/pkgs/obsidian.nix
     ../../user/pkgs/lazygit.nix
     # ../../user/pkgs/music/mpd.nix

     ../../system/wm/hypr/hyprland.nix

     ../../user/de/hypr/packages.nix
     ../../user/de/hypr/wofi.nix
     ../../user/de/hypr/hyprlock.nix
     ../../user/de/hypr/hypridle.nix

     ../../user/lang/lua.nix
     ../../user/lang/c.nix
     ../../user/lang/python/py.nix
     ../../user/lang/python/pyenv.nix
     ../../user/lang/nodejs.nix
     ../../user/lang/dart.nix
    ];

    programs = {
      git = {
        enable = true;
        userName = "paradoxical-dev";
        userEmail = userSettings.email;
      };
      neovim = {
        enable = true;
        defaultEditor = true;
      };
    };
}

{ config, pkgs, ... }:
{
    home.stateVersion = "24.05";
    home.username = "gitmoney";
    home.homeDirectory = "/home/gitmoney/";

    nixpkgs.config.allowUnfree = true;

    imports = [
     ../../user/shell/zsh.nix
     ../../user/shell/cli/fastfetch/fastfetch.nix
     ../../system/pkgs/tmux/tmux.nix

     ../../user/pkgs/zathura/zathura.nix
     ../../user/pkgs/kitty/kitty.nix
     ../../user/pkgs/obsidian.nix

     ../../user/de/hypr/packages.nix

     ../../user/lang/lua.nix
     ../../user/lang/c.nix
     ../../user/lang/py.nix
    ];

    programs = {
      git = {
        enable = true;
        userName = "paradoxical-dev";
        userEmail = "jaredonnell21@gmail.com";
      };
      neovim = {
        enable = true;
        defaultEditor = true;
      };
    };
}

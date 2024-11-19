{config, pkgs, ...}:
{
    home.stateVersion = "24.05";
    home.username = "gitmoney";
    home.homeDirectory = "/home/gitmoney/";

    imports = [
     ../../user/shell/zsh.nix
     ../../system/pkgs/tmux/tmux.nix
     ../../user/pkgs/zathura/zathura.nix
     ../../user/pkgs/kitty/kitty.nix
     ../../user/pkgs/fastfetch/fastfetch.nix
     ../../user/de/rofi/rofi.nix
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

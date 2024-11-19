{config, pkgs, ...}:

let
  zshConf = import ../default_configs/shells/zsh.nix { inherit config pkgs; };
  tmuxConf = import ../default_configs/tmux/tmux.nix { inherit config pkgs; };
  kittyConf = import ./configs/kitty/kitty.nix { inherit config pkgs; };
  fastfetchConf = import ./configs/fastfetch/fastfetch.nix { inherit config pkgs; };
  rofiConf = import ./configs/rofi/rofi.nix { inherit config pkgs; };
in 
{
    home.stateVersion = "24.05";
    home.username = "gitmoney";
    home.homeDirectory = "/home/gitmoney/";

    programs = {
      zsh = zshConf.programs.zsh;
      tmux = tmuxConf.programs.tmux;
      kitty = kittyConf.programs.kitty;
      fastfetch = fastfetchConf.programs.fastfetch;
      rofi = rofiConf.programs.rofi;
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

{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ lazygit ];
  programs.lazygit = {
    enable = true;
  };
}

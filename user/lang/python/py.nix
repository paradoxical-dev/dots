{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    python3Full
    python312Packages.pip
    pyenv
  ];
}

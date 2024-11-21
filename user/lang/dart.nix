{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    dart-sass
  ];
}

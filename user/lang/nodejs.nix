{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages_latest.nodejs
    nodePackages_latest.nodemon
  ];
}

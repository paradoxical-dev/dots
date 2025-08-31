{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ 
    luarocks
    lua5_1
    lua51Packages.sqlite
  ];
}

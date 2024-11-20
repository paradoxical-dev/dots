{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ 
    luarocks
    lua5_1
  ];
}

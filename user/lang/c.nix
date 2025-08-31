{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    gdb
    cmake
    libtool
  ];
}

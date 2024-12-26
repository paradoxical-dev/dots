{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alpaca
  ];
}

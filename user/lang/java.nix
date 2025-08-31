{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk
    leiningen
    maven
  ];
}

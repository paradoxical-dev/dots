{ pkgs, ... }:
{
  home.packages = with pkgs; [
    distrobox
  ];
  programs.distrobox = {
    enable = true;
    containers = {
      vscode = {
        image = "ubuntu:latest";
        entry = true;
      };
    };
  };
}

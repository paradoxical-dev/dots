{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (import ./open-webui.nix { inherit pkgs; })
  ];  
}

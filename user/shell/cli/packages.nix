{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    eza
    lshw
    bottom
    ddgr
    fzf
  ];
}

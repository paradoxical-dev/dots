{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    eza
    lshw
    bottom
    ddgr
    fzf
    chafa
    timg
    figlet
    bc
    lm_sensors
    smartmontools
    tldr
    bat
    jq
    fd
    file
    lesspipe
    exiftool
  ];
}

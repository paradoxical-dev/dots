{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    bc
    bottom
    chafa
    ddgr
    entr
    exiftool
    eza
    fastfetch
    fd
    figlet
    file
    fzf
    httrack
    jq
    lesspipe
    lm_sensors
    lshw
    smartmontools
    timg
    tldr
  ];
}

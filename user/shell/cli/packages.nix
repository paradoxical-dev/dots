{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    bc
    bottom
    chafa
    commitizen
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
    openssl
    smartmontools
    timg
    tldr
  ];
}

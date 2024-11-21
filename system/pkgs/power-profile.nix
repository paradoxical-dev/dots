{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    power-profiles-daemon
  ];
  services.power-profiles-daemon.enable = true;
}

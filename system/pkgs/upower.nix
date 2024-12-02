{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    upower
  ];  
  services.upower = {
    enable = true;
  };
}

{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pipewire
    rtkit
  ];
  services.pipewire = {
    enable = true;
    audio.enable = true;
    systemWide = true;
  };
  security.rtkit.enable = true;
}

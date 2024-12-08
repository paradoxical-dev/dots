{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firewalld
  ];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
  };
}

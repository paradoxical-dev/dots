{ config, pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    ollama
  ];

  services.ollama.enable = true;
  services.ollama.acceleration = "cuda";
  systemd.services.ollama = {
    serviceConfig = {
      User = "gitmoney";
      Environment = [
	"OLLAMA_MODELS=/home/gitmoney/.ollama/models"
	"__NV_PRIME_RENDER_OFFLOAD=1"
	"__GLX_VENDOR_LIBRARY_NAME=nvidia"
      ];
      DynamicUser = lib.mkForce false;
      ProtectHome = lib.mkForce false;
    };
  };
}

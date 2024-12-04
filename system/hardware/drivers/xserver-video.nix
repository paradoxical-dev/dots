{ config, pkgs, systemSettings, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers =
      if systemSettings.gpu.type == "hybrid" then
        [
          (if systemSettings.gpu.hybrid.iGpuType == "amd"
          then "amdgpu"
          else "intel")
          "nvidia"
        ]
      else if systemSettings.gpu.type == "nvidia" then
        [ "nvidia" ]
      else if systemSettings.gpu.type == "amd" then
        [ "amdgpu" ]
      else if systemSettings.gpu.type == "intel" then
        [ "intel" ]
      else
        throw "Unknown GPU type: ${systemSettings.gpu.type}";
  };
}

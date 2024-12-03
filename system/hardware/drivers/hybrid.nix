{ config, lib, pkgs, systemSettings, ...}:
{
  # Disable nvidia card for hyprland
  environment.variables.AQ_DRM_DEVICES = "/dev/dri/${systemSettings.gpu.hybrid.primaryCard}";

  hardware.graphics = {
   enable = true;
  };

  hardware.nvidia = {

    modesetting.enable = true;

    powerManagement.enable = true;

    powerManagement.finegrained = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
	      enable = true;
	      enableOffloadCmd = true;
      };
      ${if systemSettings.gpu.hybrid.iGpuType == "amd" then
        "amdgpuBusId"
      else "intelBusId"} = "${systemSettings.gpu.hybrid.iGpuBusId}";
      nvidiaBusId = "${systemSettings.gpu.hybrid.dGpuBusID}";
    };

  };
}

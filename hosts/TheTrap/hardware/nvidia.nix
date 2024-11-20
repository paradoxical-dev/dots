{ config, lib, pkgs, ...}:
{
  # Disable nvidia card for hyprland
  environment.variables.AQ_DRM_DEVICES = "/dev/dri/card2";

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
      amdgpuBusId = "PCI:0:6:0";
      nvidiaBusId = "PCI:0:1:0";
    };

  };
}

{ config, pkgs, grub2-themes, ... }:
{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    efiInstallAsRemovable = true;
  };
  boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
  };
}

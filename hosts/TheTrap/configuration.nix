{ config, pkgs, lib, systemSettings, userSettings, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system/hardware/drivers/${systemSettings.gpu.type}.nix
      ../../system/hardware/bluetooth.nix
      ../../system/hardware/pipewire.nix

      ../../system/boot/grub/${systemSettings.bootmode}.nix
      ../../system/boot/international.nix

      ../../user/shell/cli/packages.nix
      ../../user/shell/starship/starship.nix

      ../../system/pkgs/ollama.nix
      ../../system/pkgs/open-webui/open-webui.nix
      ../../system/pkgs/power-profile.nix
      ../../system/pkgs/upower.nix
      ../../system/pkgs/sddm.nix
      ../../system/wm/hypr/packages.nix
    ];

  networking.hostName = systemSettings.hostname; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.${userSettings.shell};
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = userSettings.username;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Xserver
  services.xserver = {
    enable = true;
    videoDrivers =
    if systemSettings.gpu.type == "hybrid" then 
      [ (if systemSettings.gpu.hybrid.iGpuType == "amd" 
           then "amdgpu" 
           else "intel") 
        "nvidia" ]
    else if systemSettings.gpu.type == "nvidia" then 
      [ "nvidia" ]
    else if systemSettings.gpu.type == "amd" then
      [ "amdgpu" ];
    else if systemSettings.gpu.type == "intel" then
      [ "intel" ];
    else
      throw "Unknown GPU type: ${systemSettings.gpu.type}";
  };

  #ZSH
  users.defaultUserShell = pkgs.${userSettings.shell};
  programs.${userSettings.shell}.enable = true;

  environment.systemPackages = with pkgs; [
    pkg-config
    os-prober
    libnotify
    brightnessctl
    wget
    curl
    unzip
    ripgrep

    tmux
    neovim
    git
  ];

  # DCONF
  programs.dconf.enable = true;

  # FONTS
  fonts.packages = userSettings.nerdFonts ++ userSettings.fonts;

  # CODEIUM FIX
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # KERNEL PKG
  boot.kernelPackages = pkgs.linuxPackages;

  # ELECTRON APPS WAYLAND
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # FLAKES
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}

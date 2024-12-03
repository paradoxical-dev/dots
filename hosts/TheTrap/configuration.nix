{ config, pkgs, lib, systemSettings, userSettings, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hardware/nvidia.nix
      ./hardware/bluetooth.nix
      ./hardware/pipewire.nix

      ../../system/boot/grub/efi.nix
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
    videoDrivers = [ "amdgpu" "nvidia" ];
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

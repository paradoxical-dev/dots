{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hardware/nvidia.nix
      ./hardware/bluetooth.nix

      ../../system/boot/grub/efi.nix
      ../../system/boot/international.nix
      ../../user/de/sddm.nix

      ../../user/shell/cli/packages.nix
      ../../user/shell/starship/starship.nix

      ../../system/pkgs/ollama.nix
      ../../system/wm/hypr/packages.nix
    ];

  networking.hostName = "TheTrap"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gitmoney = {
    isNormalUser = true;
    description = "Git Money";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "gitmoney";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Xserver
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" "nvidia" ];
  };

  #ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    os-prober
    brightnessctl
    wget
    curl
    unzip
    ripgrep
    tmux
    neovim
    git
  ];

  # CODEIUM FIX
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # KERNEL PKG
  boot.kernelPackages = pkgs.linuxPackages;

  # ELECTRON APPS WAYLAND
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # FLAKES
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

}

{ config, pkgs, lib, systemSettings, userSettings, grub2-themes, sddm-sugar-candy-nix, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../system/hardware/drivers/${systemSettings.gpu.type}.nix
      ../../system/hardware/drivers/cuda-cache.nix
      ../../system/hardware/drivers/xserver-video.nix
      ../../system/hardware/bluetooth.nix
      ../../system/hardware/pipewire.nix
      ../../system/hardware/power-profile.nix

      ../../system/security/firewall.nix
      ../../system/security/unbound.nix
      ../../system/security/sysctl.nix
      ../../system/security/fail2ban.nix
      ../../system/security/sudo.nix

      ../../system/boot/grub/${systemSettings.bootmode}.nix
      grub2-themes.nixosModules.default
      ../../system/boot/international.nix

      ../../system/pkgs/sddm.nix
      sddm-sugar-candy-nix.nixosModules.default

      ../../user/shell/cli/packages.nix
      ../../user/shell/starship/starship.nix

      ../../system/pkgs/docker.nix
      ../../system/pkgs/vm.nix
      ../../system/pkgs/aider.nix
      ../../system/wm/hypr/packages.nix
    ];

  nixpkgs.overlays = [
    sddm-sugar-candy-nix.overlays.default
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
    packages = with pkgs; [ ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = userSettings.username;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # ZSH
  users.defaultUserShell = pkgs.${userSettings.shell};
  programs.${userSettings.shell}.enable = true;

  # Documentation
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.man.generateCaches = true;
  documentation.dev.enable = true;
  documentation.nixos.enable = true;

  environment.systemPackages = with pkgs; [
    pkg-config
    os-prober
    cron
    upower
    brightnessctl
    libnotify
    wget
    curl
    unzip
    ripgrep
    man-pages
    man-pages-posix

    tmux
    neovim
    git

    # TEST #
    # python3Packages.pynvim
    # python3Packages.prompt-toolkit
    # python3Packages.jupyter-client
    # python3Packages.pillow
  ];

  # UPOWER
  services.upower.enable = true;

  # DCONF
  programs.dconf.enable = true;

  # FONTS
  fonts.packages = userSettings.nerdFonts ++ userSettings.fonts;

  # CODEIUM FIX
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];

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

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "ParadoxLabs"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  # DM
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "hyprland";
    sessionPackages = with pkgs; [ hyprland ];
  };

  #ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # TOOLS
    os-prober
    wget
    curl
    unzip
    ddgr
    fzf
    ripgrep
    fastfetch
    eza
    lshw
    bottom

    ollama

  # DEV
    neovim
    obsidian
    git
    kitty
    gcc
    luarocks
    lua5_1
    python3

  # D.E
    sddm
    starship
    hyprland
    hyprpaper
    wlroots
    xwayland
    waybar
    grim
    slurp
    xdg-desktop-portal-hyprland
    wl-clipboard
    rofi
    dolphin
    breeze-icons
    firefox-wayland
  ];

  # OLLAMA
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

  # BLUETOOTH
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # CODEIUM FIX
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # KERNEL PKG
  boot.kernelPackages = pkgs.linuxPackages;

  # NVIDIA DISABLE FOR HYPRLAND
  environment.variables.AQ_DRM_DEVICES = "/dev/dri/card2";

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

{ config, pkgs, userSettings, hyprpanel, ... }:
{
  home.stateVersion = "24.05";
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username + "/";

  # Set system theme environment variable
  home.sessionVariables = {
    SYSTEM_THEME = userSettings.theme;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ hyprpanel.overlay ];

  imports = [
    ../../user/shell/${userSettings.shell}.nix
    ../../user/shell/cli/fastfetch/default.nix
    ../../user/pkgs/tmux/default.nix

    ../../user/pkgs/zathura.nix
    ../../user/pkgs/kitty/default.nix
    ../../user/pkgs/obsidian.nix
    ../../user/pkgs/lazygit.nix
    ../../user/pkgs/ags.nix

    ../../user/pkgs/music/mpd/mpd.nix
    ../../user/pkgs/music/mpd/mpdris.nix
    ../../user/pkgs/music/cava.nix

    ../../system/wm/hypr/hyprland.nix
    ../../system/wm/hypr/hyprpaper/default.nix

    ../../user/de/hypr/packages.nix
    ../../user/de/hypr/gtk/default.nix
    ../../user/de/hypr/wofi.nix
    ../../user/de/hypr/hyprlock.nix
    ../../user/de/hypr/hypridle.nix

    ../../user/lang/lua.nix
    ../../user/lang/c.nix
    ../../user/lang/rust.nix
    ../../user/lang/python/py.nix
    ../../user/lang/python/pyenv.nix
    ../../user/lang/nodejs.nix
    ../../user/lang/dart.nix
  ];

  programs = {
    git = {
      enable = true;
      userName = "paradoxical-dev";
      userEmail = userSettings.email;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}

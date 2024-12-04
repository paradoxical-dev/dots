{ config, pkgs, userSettings, ... }:
let
  themeConfig = {
    yin = {
      iconName = "Adwaita";
      iconPackage = pkgs.adwaita-icon-theme;
      cursorName = "Bibata-Modern-Classic";
      cursorPackage = pkgs.bibata-cursors;
    };
  };

  currentTheme = themeConfig.${userSettings.theme} or {
    iconName = "Adwaita";
    iconPackage = pkgs.adwaita-icon-theme;
    cursorName = "Bibata-Modern-Classic";
    cursorPackage = pkgs.bibata-cursors;
  };
in
{
  home.packages = with pkgs; [
    gtk3
    gtk4
    dconf
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = currentTheme.iconName;
      package = currentTheme.iconPackage;
    };
    cursorTheme = {
      name = currentTheme.cursorName;
      package = currentTheme.cursorPackage;
      size = 24;
    };
  };
  home.pointerCursor = {
    name = currentTheme.cursorName;
    package = currentTheme.cursorPackage;
    gtk.enable = true;
  };
}

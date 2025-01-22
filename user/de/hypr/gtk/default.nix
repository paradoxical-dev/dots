{ pkgs, userSettings, ... }:
let
  themeConfig = {
    yin = {
      themeName = "Graphite";
      themePackage = pkgs.graphite-gtk-theme;
      iconName = "Adwaita";
      iconPackage = pkgs.adwaita-icon-theme;
      cursorName = "Bibata-Modern-Classic";
      cursorPackage = pkgs.bibata-cursors;
    };

    yang = {
      themeName = "Graphite-Dark";
      themePackage = pkgs.graphite-gtk-theme;
      iconName = "Adwaita";
      iconPackage = pkgs.adwaita-icon-theme;
      cursorName = "Bibata-Modern-Ice";
      cursorPackage = pkgs.bibata-cursors;
    };

    burst = {
      themeName = "Tokyonight-Dark";
      themePackage = pkgs.tokyonight-gtk-theme;
      iconName = "Adwaita";
      iconPackage = pkgs.adwaita-icon-theme;
      cursorName = "Bibata-Modern-Ice";
      cursorPackage = pkgs.bibata-cursors;
    };

    shards = {
      themeName = "Graphite-Dark";
      themePackage = pkgs.graphite-gtk-theme;
      iconName = "Adwaita";
      iconPackage = pkgs.adwaita-icon-theme;
      cursorName = "Bibata-Modern-Ice";
      cursorPackage = pkgs.bibata-cursors;
    };
  };

  currentTheme = themeConfig.${userSettings.theme} or {
    themeName = null;
    themePackage = null;
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
    theme = {
      name = currentTheme.themeName;
      package = currentTheme.themePackage;
    };
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

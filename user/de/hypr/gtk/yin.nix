{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 48;
    };
    # gtk2.extraConfig = ''
    #   gtk-cursor-theme-name = "Bibata-Modern-Classic";
    # '';
    # gtk3.extraConfig = {
    #   gtk-cursor-theme-name = "Bibata-Modern-Classic";
    # };
    # gtk4.extraConfig = {
    #   gtk-cursor-theme-name = "Bibata-Modern-Classic";
    # };
  };
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };
}

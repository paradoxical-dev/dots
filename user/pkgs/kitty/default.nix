{ config, pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [ kitty ];

  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+;" = "next_layout";
    };
    shellIntegration.enableBashIntegration = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_opacity = 0.8;
      active_tab_background = "#E29ECA";
      inactive_tab_background = "#090610";
      tab_title_template = "{tab.active_oldest_wd}";
      active_tab_title_template = "{title}";
      tab_active_symbol = "󱌣";
      tab_title_max_length = 50;
      window_border_width = 1;
      active_border_color = "#414141";
      inactive_border_color = "#414141";
      cursor_shape = "block";
    };
    extraConfig = ''
      include ~/dots/user/pkgs/kitty/themes/${userSettings.theme}.conf

      window_padding_width 5 15

      enabled_layouts    Grid, Stack

      cursor_trail       3

      font_size          ${userSettings.fontSize}
      font_family        JetBrainsMonoNL NFM Regular
      italic_font        Victor Mono Italic
      bold_italic_font   Victor Mono Bold Italic
      '';
  };

}

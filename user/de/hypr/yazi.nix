{ userSettings, ... }:
let
  themes = {
    yin = { };
    yang = { };
    burst = {
      mode = {
        normal_main = { fg = "#17171f"; bg = "#a8a1be"; bold = true; };
        normal_alt = { fg = "#a8a1be"; bg = "#2b2731"; };
        select_main = { fg = "#17171f"; bg = "#be7c7d"; bold = true; };
        select_alt = { fg = "#be7c7d"; bg = "#342a2a"; };
      };
    };
    shards = { };
  };
  currentTheme = themes.${userSettings.theme};
in
{
  programs.yazi = {
    enable = true;
    theme = currentTheme;
    settings = {
      opener = {
        open = [
          { run = ''xdg-open "$@"''; orphan = true; desc = "Open"; }
        ];
      };
    };
  };
}

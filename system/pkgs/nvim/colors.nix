{ userSettings, ... }:
# A simple update for neovims colorscheme
let
  currentTheme = import ./themes/${userSettings.theme}.nix;
in
{
  home.file.".config/nvim/lua/plugins/theme.lua".text = currentTheme.config;
}

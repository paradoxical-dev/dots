{ userSettings, ... }:
# A simple update for neovims colorscheme
let
  currentTheme =
    if userSettings.nvim.nvim_compile then
      {
        config =
          ''
            -- WARN: This file has been generated by home manager and pulled from the dotfiles repo
            return {
              {
                "paradoxical-dev/color-compiler.nvim",
                lazy = false,
                priority = 1000,
                opts = {
                  extensions = {
                    "dap",
                    "diffview",
                    "flash",
                    "flog",
                    "gitsigns",
                    "harpoon",
                    "heirline",
                    "lazy",
                    "markview",
                    "mason",
                    "neotest",
                    "semantics",
                    "snacks",
                    "telescope",
                    "ufo",
                    "which-key",
                  },
                  theme = "${userSettings.theme}"
                }
              }
            }
          '';
      }
    else import ./themes/${userSettings.theme}.nix;
in
{
  home.file.".config/nvim/lua/plugins/theme.lua".text = currentTheme.config;
}

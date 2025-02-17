-- INFO:  optional profiling; start nvim with `PROF=1 nvim`
if vim.env.PROF then
	local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
	vim.opt.rtp:append(snacks)
	require("snacks.profiler").startup({
		startup = {
			event = "UIEnter",
		},
		presets = {
			startup = {
				min_time = 0,
				sort = true,
			},
		},
	})
end
--

-- BUG: temporary fix for :Inspect command bug. See: https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
--

-- INFO: fix python path
--
vim.g.python3_host_prog = "~/.nix-profile/bin/python3"
--

-- INFO: bootstrap lazy.nvim
local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
	vim.fn.getchar()
	vim.cmd.quit()
end
--

-- INFO: Snacks debugging
_G.dd = function(...)
	Snacks.debug.inspect(...)
end
_G.bt = function()
	Snacks.debug.backtrace()
end
vim.print = _G.dd
--

-- INFO: add local rocks path
-- this is only needed for non NixOS unsupported luarocks such as gumbo
local lua_path = vim.fn.stdpath("config")
	.. "/lua/rocks/share/lua/5.1/?.lua;"
	.. vim.fn.stdpath("config")
	.. "/lua/rocks/share/lua/5.1/?/init.lua"
local lua_cpath = vim.fn.stdpath("config") .. "/lua/rocks/lib/lua/5.1/?.so"

package.path = package.path .. ";" .. lua_path
package.cpath = package.cpath .. ";" .. lua_cpath
--

require("lazy_setup")

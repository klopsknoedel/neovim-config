-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Plugins
return packer.startup(function (use)
	use {
		-- Packer
		"wbthomason/packer.nvim",
    
    -- Look/Behaviour
    { "nvim-lualine/lualine.nvim", requires = { 'nvim-tree/nvim-web-devicons', opt = true }},

		-- Colorschemes
		"shaunsingh/nord.nvim", -- Nord
    "folke/tokyonight.nvim" -- Tokyo Night
	}

  if packer_bootstrap then
    packer.sync()
  end
end)

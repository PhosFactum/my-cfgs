-- Basic configuration of Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ 
	  "git", 
	  "clone", 
	  "--filter=blob:none", 
	  "--branch=stable", 
	  lazyrepo, 
	  lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Imports of plugins
require("lazy").setup({
	-- Hop: TEST PLUGIN, NEED TO BE TRIED :D
    { 'phaazon/hop.nvim' },
    	-- Neotree: float filesystem navigation
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
	dependencies = {
	    "nvim-lua/plenary.nvim",
	    "MunifTanjim/nui.nvim",
	    "nvim-tree/nvim-web-devicons",
	    "s1n7ax/nvim-window-picker",
	},
	config = function()
	    require("plugins.neotree")
	end,
    },

})


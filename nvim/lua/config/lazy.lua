local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	opts = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			vim.list_extend(opts.ensure_installed, { "c", "cpp" })
		end
	end,
	spec = {
		-- add lazyvim and import its plugins
		{ "lazyvim/lazyvim", import = "lazyvim.plugins" },
		-- import any extras modules here
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.python" },
		{ import = "lazyvim.plugins.extras.lang.clangd" },
		-- { import = "lazyvim.plugins.extras.ui.mini-animate" },
		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- by default, only lazyvim plugins will be lazy-loaded. your custom plugins will load during startup.
		-- if you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- it's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "gruvbox", "tokyonight", "habamax" } },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				"netrwplugin",
				"rplugin",
				"tarplugin",
				"tohtml",
				"tutor",
				"zipplugin",
			},
		},
	},
	ui = {
		custom_keys = {
			["<localleader>d"] = function(plugin)
				dd(plugin)
			end,
		},
	},
	debug = false,
})

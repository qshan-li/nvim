-- VS Code 模式下启用的插件
local M = {}

function M.setup()
	local data_dir = vim.fn.stdpath("data") .. "/site/"
	local lazy_path = data_dir .. "lazy/lazy.nvim"

	-- 确保 lazy.nvim 已安装
	if not vim.uv.fs_stat(lazy_path) then
		local lazy_repo = "https://github.com/folke/lazy.nvim.git"
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--branch=stable",
			lazy_repo,
			lazy_path,
		})
	end
	vim.opt.rtp:prepend(lazy_path)

	-- 插件配置
	local plugins = {
		-- flash.nvim: 快速跳转
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			opts = {
				labels = "asdfghjklqwertyuiopzxcvbnm",
				label = {
					uppercase = true,
					current = true,
					distance = true,
				},
				modes = {
					search = { enabled = true },
					char = {
						enabled = true,
						autohide = false,
						jump_labels = true,
						multi_line = true,
						label = { exclude = "hjkliardc" },
					},
				},
			},
			keys = {
				{
					"s",
					mode = { "n", "x", "o" },
					function()
						require("flash").jump()
					end,
					desc = "Flash",
				},
				{
					"S",
					mode = { "n", "x", "o" },
					function()
						require("flash").treesitter()
					end,
					desc = "Flash Treesitter",
				},
				{
					"r",
					mode = "o",
					function()
						require("flash").remote()
					end,
					desc = "Remote Flash",
				},
				{
					"R",
					mode = { "o", "x" },
					function()
						require("flash").treesitter_search()
					end,
					desc = "Treesitter Search",
				},
				{
					"<c-s>",
					mode = { "c" },
					function()
						require("flash").toggle()
					end,
					desc = "Toggle Flash Search",
				},
			},
		},

		-- hop.nvim: 可视化跳转
		{
			"smoka7/hop.nvim",
			version = "*",
			event = "VeryLazy",
			opts = { keys = "etovxqpdygfblzhckisuran" },
			keys = {
				{ "<leader>w", "<Cmd>HopWordMW<CR>", mode = { "n", "v" }, desc = "Hop Word" },
				{ "<leader>j", "<Cmd>HopLineMW<CR>", mode = { "n", "v" }, desc = "Hop Line" },
				{ "<leader>k", "<Cmd>HopLineMW<CR>", mode = { "n", "v" }, desc = "Hop Line" },
				{ "<leader>c", "<Cmd>HopChar1MW<CR>", mode = { "n", "v" }, desc = "Hop Char1" },
				{ "<leader>C", "<Cmd>HopChar2MW<CR>", mode = { "n", "v" }, desc = "Hop Char2" },
			},
		},

		-- mini.surround: 环绕编辑
		{
			"echasnovski/mini.surround",
			version = "*",
			event = "VeryLazy",
			opts = {
				-- 默认快捷键:
				-- sa: Add surrounding (e.g., saiw" 给单词加双引号)
				-- sd: Delete surrounding (e.g., sd" 删除双引号)
				-- sr: Replace surrounding (e.g., sr"' 把双引号换成单引号)
				-- sf: Find surrounding (向右查找)
				-- sF: Find surrounding (向左查找)
				-- sh: Highlight surrounding
				-- sn: Update n_lines
				mappings = {
					add = "sa",
					delete = "sd",
					replace = "sr",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					update_n_lines = "sn",
				},
			},
		},

		-- vim-matchup: 增强 % 匹配跳转
		{
			"andymass/vim-matchup",
			event = "VeryLazy",
			init = function()
				vim.g.matchup_transmute_enabled = 1
				vim.g.matchup_surround_enabled = 1
				vim.g.matchup_matchparen_offscreen = { method = "popup" }
			end,
		},
	}

	-- 初始化 lazy.nvim
	require("lazy").setup(plugins, {
		root = data_dir .. "lazy",
		install = { missing = true },
		ui = { border = "rounded" },
		performance = {
			rtp = {
				disabled_plugins = {
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tohtml",
					"tutor",
				},
			},
		},
	})
end

return M

return vim.schedule_wrap(function()
	vim.api.nvim_set_option_value("indentexpr", "v:lua.require'nvim-treesitter'.indentexpr()", {})
	require("pure-nvim.utils").load_plugin("nvim-treesitter", {
		highlight = {
			enable = true,
			disable = function(lang, buf)
				-- Disable on very large files
				local max_filesize = 1024 * 1024 -- 1 MB
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true },
	})
end)

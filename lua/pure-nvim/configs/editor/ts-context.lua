return function()
	require("pure-nvim.utils").load_plugin("treesitter-context", {
		enable = true,
		line_numbers = true,
		max_lines = 3,
		min_window_height = 0,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "cursor",
		on_attach = function(bufnr)
			return vim.bo[bufnr].filetype ~= "vue"
		end,
		-- Ensure compatibility with Glance's preview window
		zindex = 50,
	})
end

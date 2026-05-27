return function()
	require("tiny-code-action").setup({
		backend = "vim",
		picker = {
			"buffer",
			opts = {
				keymaps = {
					close = { "q", "<Esc>" },
					select = "<CR>",
					preview = "K",
					preview_close = { "q", "<Esc>" },
				},
			},
		},
	})
end

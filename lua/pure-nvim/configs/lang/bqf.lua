return function()
	require("pure-nvim.utils").load_plugin("bqf", {
		preview = {
			border = "single",
			wrap = true,
			winblend = 0,
		},
	})
end

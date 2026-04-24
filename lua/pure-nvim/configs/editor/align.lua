return function()
	require("pure-nvim.utils").load_plugin("mini.align", {
		silent = true,
		mappings = {
			start = "gea",
			start_with_preview = "geA",
		},
	})
end

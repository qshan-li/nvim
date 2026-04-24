return function()
	local icons = { ui = require("pure-nvim.utils.icons").get("ui", true) }

	require("pure-nvim.utils").load_plugin("fzf-lua", {
		{ "telescope" },
		defaults = {
			prompt = icons.ui.Telescope .. " ",
		},
	})
end

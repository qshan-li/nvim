return function()
	require("pure-nvim.utils").load_plugin("mini.cursorword", {
		-- Delay (in ms) between when cursor moved and when highlighting appeared
		delay = 200,
	})
	require("pure-nvim.utils").gen_cursorword_hl()
end

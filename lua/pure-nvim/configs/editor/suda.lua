return function()
	vim.g["suda#prompt"] = "Enter administrator password: "

	require("pure-nvim.utils").load_plugin("suda", nil, true)
end

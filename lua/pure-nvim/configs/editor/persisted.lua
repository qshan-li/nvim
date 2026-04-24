return function()
	require("pure-nvim.utils").load_plugin("persisted", {
		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
		autostart = true,
		autoload = true,
		follow_cwd = true,
		use_git_branch = true,
		should_save = function()
			return vim.bo.filetype == "minintro" and false or true
		end,
	})
end

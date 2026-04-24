return function(_, opts)
	local color = opts.color or "#FF0000"

	require("minintro").setup({
		color = color,
	})

	local apply_highlight = function()
		local ns = vim.api.nvim_get_namespaces().minintro
		if not ns then
			error("minintro highlight namespace not found")
		end

		vim.api.nvim_set_hl(ns, "Default", {
			fg = color,
			ctermfg = 196,
		})
	end

	apply_highlight()

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "minintro",
		callback = function(args)
			local ns = vim.api.nvim_get_namespaces().minintro
			if not ns then
				error("minintro highlight namespace not found")
			end

			local win_id = vim.fn.bufwinid(args.buf)
			if win_id == -1 then
				error("minintro window not found")
			end

			apply_highlight()
			vim.api.nvim_win_set_hl_ns(win_id, ns)
		end,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = apply_highlight,
	})
end

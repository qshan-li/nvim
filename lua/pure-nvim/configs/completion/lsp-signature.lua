return function()
	require("pure-nvim.utils").load_plugin("lsp_signature", {
		bind = true,
		-- TODO: Remove the following line when nvim-cmp#1613 gets resolved
		check_completion_visible = false,
		floating_window = true,
		floating_window_above_cur_line = true,
		hi_parameter = "Search",
		hint_enable = true,
		transparency = nil, -- disabled by default, allow floating win transparent value 1~100
		wrap = true,
		zindex = 45, -- avoid overlap with nvim.cmp
		handler_opts = { border = "single" },
		-- Ignore vtsls/TypeScript internal errors (upstream bug in TS 5.9.x)
		ignore_error = function(err, ctx, _)
			if ctx and ctx.client_id then
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				if client and client.name == "vtsls" then
					return true
				end
			end
			-- Also ignore generic InternalError from any LSP
			if err and err.code_name == "InternalError" then
				return true
			end
			return false
		end,
	})
end

return function()
	require("mini.notify").setup({
		content = {
			format = nil,
			sort = nil,
		},
		lsp_progress = {
			enable = false,
		},
		window = {
			config = {
				border = "single",
			},
			max_width_share = 0.4,
			winblend = 0,
		},
	})

	local notify = require("mini.notify").make_notify({
		ERROR = { duration = 5000 },
		WARN = { duration = 4000 },
		INFO = { duration = 2000 },
		DEBUG = { duration = 0 },
		TRACE = { duration = 0 },
		OFF = { duration = 0 },
	})

	vim.notify = function(msg, level, opts)
		if type(msg) ~= "string" then
			return notify(msg, level, opts)
		end

		local lowered = msg:lower()
		if
			lowered:match("created")
			or lowered:match("yanked")
			or lowered:match("renamed")
			or lowered:match("deleted")
			or lowered:match("copied")
			or lowered:match("moved")
		then
			return
		end
		notify(msg, level, opts)
	end
end

return function()
	local fallback_commentstrings = {
		block = "/* %s */",
		line = "// %s",
	}
	local ts_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

	require("pure-nvim.utils").load_plugin("Comment", {
		ignore = "^$",
		pre_hook = function(ctx)
			local ok, commentstring = pcall(ts_pre_hook, ctx)
			if ok and commentstring then
				return commentstring
			end

			if vim.bo.commentstring ~= "" then
				return vim.bo.commentstring
			end

			local utils = require("Comment.utils")
			if ctx.ctype == utils.ctype.blockwise then
				return fallback_commentstrings.block
			end
			return fallback_commentstrings.line
		end,
	})
end

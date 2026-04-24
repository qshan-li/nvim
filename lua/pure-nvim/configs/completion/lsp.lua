return function()
	require("completion.neoconf").setup()
	require("completion.mason").setup()
	require("completion.mason-lspconfig").setup()

	local utils = require("pure-nvim.utils")
	local opts = {
		capabilities = utils.get_lsp_capabilities(),
	}
	-- Configure LSPs that are not supported by `mason.nvim` but are available in `nvim-lspconfig`.
	-- First call |vim.lsp.config()|, then |vim.lsp.enable()| (or use `register_server`, see below)
	-- to ensure the language server is properly configured and starts automatically.
	if vim.fn.executable("dart") == 1 then
		local final_opts = vim.tbl_deep_extend("keep", require("completion.servers.dartls"), opts)
		utils.register_server("dartls", final_opts)
	end

	-- Start LSPs
	pcall(vim.cmd.LspStart)
end

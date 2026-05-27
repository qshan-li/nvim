return function()
	require("pure-nvim.utils").load_plugin("mason-null-ls", {
		ensure_installed = require("pure-nvim.core.settings").mason_null_ls_sources,
		automatic_installation = false,
		automatic_setup = true,
		handlers = {},
	})
end

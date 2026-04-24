return function(opts)
	local global_plugins = {}
	local vue_language_server_path = vim.fn.stdpath("data")
		.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
	if vim.fn.isdirectory(vue_language_server_path) == 1 then
		table.insert(global_plugins, {
			name = "@vue/typescript-plugin",
			location = vue_language_server_path,
			languages = { "vue" },
			configNamespace = "typescript",
		})
	end

	local vtsls_config = {
		settings = {
			vtsls = {
				tsserver = {},
			},
		},
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	}

	if #global_plugins > 0 then
		vtsls_config.settings.vtsls.tsserver.globalPlugins = global_plugins
	end

	vim.lsp.config("vtsls", vim.tbl_deep_extend("force", vtsls_config, opts))
end

local completion = {}

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = require("completion.lsp"),
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "folke/neoconf.nvim" },
	},
}
completion["rachartier/tiny-code-action.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.tiny-code-action"),
}
completion["smjonas/inc-rename.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.inc-rename"),
}
completion["DNLHC/glance.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.glance"),
}
completion["dmmulroy/ts-error-translator.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = function()
		require("ts-error-translator").setup()
	end,
}
completion["rachartier/tiny-inline-diagnostic.nvim"] = {
	lazy = false,
	config = require("completion.tiny-inline-diagnostic"),
}
completion["joechrisellis/lsp-format-modifications.nvim"] = {
	lazy = true,
	event = "LspAttach",
}
completion["jay-babu/mason-null-ls.nvim"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = require("completion.mason-null-ls").setup,
	dependencies = {
		"mason-org/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
}
completion["nvimtools/none-ls.nvim"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = require("completion.null-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
completion["monkoose/neocodeium"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("completion.neocodeium"),
}
completion["hrsh7th/nvim-cmp"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("completion.cmp"),
	dependencies = {
		{ "lukas-reineke/cmp-under-comparator" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-buffer" },
	},
}

return completion

_G._command_panel = function()
	require("snacks").picker.keymaps()
end

_G._flash_esc_or_noh = function()
	local flash_active, state = pcall(function()
		return require("flash.plugins.char").state
	end)
	if flash_active and state then
		state:hide()
	else
		pcall(vim.cmd.noh)
	end
end

_G._telescope_collections = function(opts)
	require("snacks").picker.pickers()
end

_G._flash_jump_words = function()
	require("flash").jump({
		search = {
			mode = function(str)
				return "\\<" .. str
			end,
		},
	})
end

_G._flash_jump_lines = function()
	require("flash").jump({
		search = { mode = "search", max_length = 0 },
		label = { after = { 0, 0 } },
		pattern = "^",
	})
end

_G._flash_jump_chars = function()
	require("flash").jump()
end

_G._flash_jump_treesitter = function()
	require("flash").treesitter()
end

_G._toggle_inlayhint = function()
	local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not is_enabled)
	vim.notify(
		(is_enabled and "Inlay hint disabled successfully" or "Inlay hint enabled successfully"),
		vim.log.levels.INFO,
		{ title = "LSP Inlay Hint" }
	)
end

_G._toggle_diagnostic_virtual_text = function()
	require("tiny-inline-diagnostic").toggle()
	local enabled = require("tiny-inline-diagnostic.diagnostic").user_toggle_state
	vim.notify(
		"Inline diagnostics " .. (enabled and "enabled" or "disabled") .. " successfully",
		vim.log.levels.INFO,
		{ title = "LSP Diagnostic" }
	)
end

local _lazygit = nil
_G._toggle_lazygit = function()
	if vim.fn.executable("lazygit") == 1 then
		if not _lazygit then
			_lazygit = require("toggleterm.terminal").Terminal:new({
				cmd = "lazygit",
				direction = "float",
				close_on_exit = true,
				hidden = true,
			})
		end
		_lazygit:toggle()
	else
		vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end
end

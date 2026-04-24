local lsp_state = { progress = "" }
local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "", "" }

vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("LualineLspProgress", { clear = true }),
	pattern = { "begin", "report", "end" },
	callback = function(args)
		-- Get the payload
		local data = args.data and args.data.params and args.data.params.value
		if not data then
			return
		end

		-- If it's the end event, clear; else build "<spinner> XX% <title> <loaded>"
		if data.kind == "end" then
			lsp_state.progress = ""
		else
			local pct = data.percentage or 0
			local idx = 1 + ((pct - pct % 10) / 10)
			local spinner = spinners[idx]

			local progress = ""
			if data.message then
				local start, stop = data.message:find("^%d+/%d+")
				if start then
					progress = data.message:sub(start, stop)
				end
			end

			lsp_state.progress = spinner
				.. " "
				.. tostring(pct)
				.. "%% "
				.. (data.title or "")
				.. (progress ~= "" and " " .. progress or "")
		end

		-- Redraw statusline
		pcall(vim.cmd.redrawstatus)
	end,
})

return function()
	local icons = {
		diagnostics = require("pure-nvim.utils.icons").get("diagnostics", true),
		git = require("pure-nvim.utils.icons").get("git", true),
		git_nosep = require("pure-nvim.utils.icons").get("git"),
		misc = require("pure-nvim.utils.icons").get("misc", true),
		ui = require("pure-nvim.utils.icons").get("ui", true),
	}

	local function resolve_lualine_theme()
		local colorscheme_name = vim.g.colors_name or ""
		if colorscheme_name:find("rose%-pine") then
			return "rose-pine"
		end
		return "auto"
	end

	local conditionals = {
		has_enough_room = function()
			return vim.o.columns > 100
		end,
		has_comp_before = function()
			return vim.bo.filetype ~= ""
		end,
		has_git = function()
			local gitdir = vim.fs.find(".git", {
				limit = 1,
				upward = true,
				type = "directory",
				path = vim.fn.expand("%:p:h"),
			})
			return #gitdir > 0
		end,
	}

	---@class lualine_hlgrp
	---@field fg string
	---@field bg string
	---@field gui string?
	local utils = {
		force_centering = function()
			return "%="
		end,
		abbreviate_path = function(path)
			local home = require("pure-nvim.core.global").home
			if path:find(home, 1, true) == 1 then
				path = "~" .. path:sub(#home + 1)
			end
			return path
		end,
	}

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	local components = {
		separator = { -- use as section separators
			function()
				return "│"
			end,
			padding = 0,
			separator = { left = "", right = "" },
		},

		file_status = {
			function()
				local function is_new_file()
					local filename = vim.fn.expand("%")
					return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
				end

				local symbols = {}
				if vim.bo.modified then
					table.insert(symbols, "[+]")
				end
				if vim.bo.modifiable == false then
					table.insert(symbols, "[-]")
				end
				if vim.bo.readonly == true then
					table.insert(symbols, "[RO]")
				end
				if is_new_file() then
					table.insert(symbols, "[New]")
				end
				return #symbols > 0 and table.concat(symbols, "") or ""
			end,
			padding = { left = -1, right = 1 },
			cond = conditionals.has_comp_before,
		},

		lsp = {
			function()
				local buf_ft = vim.bo.filetype
				local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
				local lsp_lists = {}
				local available_servers = {}
				if next(clients) == nil then
					return icons.misc.NoActiveLsp -- No server available
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					local client_name = client.name
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						-- Avoid adding servers that already exist.
						if not lsp_lists[client_name] then
							lsp_lists[client_name] = true
							table.insert(available_servers, client_name)
						end
					end
				end

				return next(available_servers) == nil and icons.misc.NoActiveLsp
					or string.format(
						"%s[%s] %s",
						icons.misc.LspAvailable,
						table.concat(available_servers, ", "),
						lsp_state.progress
					)
			end,
			cond = conditionals.has_enough_room,
		},

		python_venv = {
			function()
				local function env_cleanup(venv)
					if string.find(venv, "/") then
						local final_venv = venv
						for w in venv:gmatch("([^/]+)") do
							final_venv = w
						end
						venv = final_venv
					end
					return venv
				end

				if vim.bo.filetype == "python" then
					local venv = vim.env.CONDA_DEFAULT_ENV
					if venv then
						return icons.misc.PyEnv .. env_cleanup(venv)
					end
					venv = vim.env.VIRTUAL_ENV
					if venv then
						return icons.misc.PyEnv .. env_cleanup(venv)
					end
				end
				return ""
			end,
			cond = conditionals.has_enough_room,
		},

		tabwidth = {
			function()
				return icons.ui.Tab .. vim.bo.tabstop
			end,
			padding = 1,
		},

		cwd = {
			function()
				return icons.ui.FolderWithHeart .. utils.abbreviate_path(vim.fs.normalize(vim.uv.cwd()))
			end,
		},

		file_location = {
			function()
				local cursorline = vim.fn.line(".")
				local cursorcol = vim.fn.virtcol(".")
				local filelines = vim.fn.line("$")
				local position
				if cursorline == 1 then
					position = "Top"
				elseif cursorline == filelines then
					position = "Bot"
				else
					position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
				end
				return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
			end,
		},
	}

	local function build_lualine_options()
		return {
			options = {
				icons_enabled = true,
				theme = resolve_lualine_theme(),
				disabled_filetypes = { statusline = { "minintro" } },
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"filetype",
						colored = true,
						icon_only = false,
						icon = { align = "left" },
					},
					components.file_status,
					vim.tbl_extend("force", components.separator, {
						cond = function()
							return conditionals.has_git() and conditionals.has_comp_before()
						end,
					}),
				},
				lualine_c = {
					{
						"branch",
						icon = icons.git_nosep.Branch,
						cond = conditionals.has_git,
					},
					{
						"diff",
						symbols = {
							added = icons.git.Add,
							modified = icons.git.Mod_alt,
							removed = icons.git.Remove,
						},
						source = diff_source,
						colored = false,
						cond = conditionals.has_git,
						padding = { right = 1 },
					},

					{ utils.force_centering },
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn", "info", "hint" },
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warning,
							info = icons.diagnostics.Information,
							hint = icons.diagnostics.Hint_alt,
						},
					},
					components.lsp,
				},
				lualine_x = {
					{
						"encoding",
						show_bomb = true,
						fmt = string.upper,
						padding = { left = 1 },
						cond = conditionals.has_enough_room,
					},
					{
						"fileformat",
						symbols = {
							unix = "LF",
							dos = "CRLF",
							mac = "CR", -- Legacy macOS
						},
						padding = { left = 1 },
					},
					components.tabwidth,
				},
				lualine_y = {
					components.separator,
					components.python_venv,
					components.cwd,
				},
				lualine_z = { components.file_location },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		}
	end

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("LualineColorScheme", { clear = true }),
		pattern = "*",
		callback = function()
			require("lualine").setup(build_lualine_options())
		end,
	})

	require("pure-nvim.utils").load_plugin("lualine", build_lualine_options())
end

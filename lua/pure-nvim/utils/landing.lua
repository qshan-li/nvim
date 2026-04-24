local M = {}

local intro_logo = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

local augroup = vim.api.nvim_create_augroup("LandingPageRecovery", { clear = true })

local function lock_buf(buf)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

local function unlock_buf(buf)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
end

local function draw(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	local win = vim.fn.bufwinid(buf)
	if win == -1 or not vim.api.nvim_win_is_valid(win) then
		return
	end

	local screen_width = vim.api.nvim_win_get_width(win)
	local screen_height = vim.api.nvim_win_get_height(win) - vim.opt.cmdheight:get()
	local logo_width = vim.fn.strdisplaywidth(intro_logo[1])
	local logo_height = #intro_logo
	local start_col = math.floor((screen_width - logo_width) / 2)
	local start_row = math.floor((screen_height - logo_height) / 2)

	unlock_buf(buf)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

	if start_col < 0 or start_row < 0 then
		lock_buf(buf)
		return
	end

	local lines = {}
	for _ = 1, start_row do
		lines[#lines + 1] = ""
	end

	local padding = string.rep(" ", start_col)
	for _, line in ipairs(intro_logo) do
		lines[#lines + 1] = padding .. line
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
	for row = start_row, start_row + logo_height - 1 do
		vim.api.nvim_buf_add_highlight(buf, -1, "MinintroLogo", row, start_col, -1)
	end
	lock_buf(buf)
end

function M.show(target_win)
	target_win = target_win or vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_current_win(target_win)
	vim.api.nvim_win_set_buf(target_win, buf)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("filetype", "minintro", { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.list = false
	vim.opt_local.fillchars = { eob = " " }
	vim.opt_local.colorcolumn = "0"

	draw(buf)

	vim.api.nvim_create_autocmd({ "WinResized", "VimResized" }, {
		group = augroup,
		buffer = buf,
		callback = function()
			draw(buf)
		end,
	})

	return buf
end

function M.recover_from_lonely_tree()
	local wins = vim.api.nvim_list_wins()
	if #wins ~= 1 then
		return false
	end

	local buf = vim.api.nvim_win_get_buf(wins[1])
	if vim.api.nvim_get_option_value("filetype", { buf = buf }) ~= "NvimTree" then
		return false
	end

	vim.api.nvim_buf_delete(buf, { force = true })
	M.show(wins[1])
	return true
end

return M

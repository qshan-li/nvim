local M = {}

local function copy_with_osc52(text)
	local osc52 = "\027]52;c;" .. vim.fn.system("base64 -w0", text):gsub("\n", "") .. "\027\\"
	io.stdout:write(osc52)
	io.stdout:flush()
end

function M.copy(text)
	if not text or text == "" then
		return false, "clipboard text is empty"
	end

	local register_ok, register_error = pcall(function()
		vim.fn.setreg("+", text)
		vim.fn.setreg("*", text)
		vim.fn.setreg('"', text)
	end)

	if vim.fn.has("wsl") == 1 and vim.fn.executable("win32yank.exe") == 1 then
		local output = vim.fn.system("win32yank.exe -i --crlf", text)
		if vim.v.shell_error ~= 0 then
			return false, output
		end
		return true
	end

	if register_ok then
		return true
	end

	copy_with_osc52(text)
	return true, register_error
end

return M

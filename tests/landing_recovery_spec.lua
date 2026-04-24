local landing = require("pure-nvim.utils.landing")

vim.cmd("only")
vim.cmd("enew")

local tree_buf = vim.api.nvim_get_current_buf()
vim.api.nvim_set_option_value("filetype", "NvimTree", { buf = tree_buf })
vim.api.nvim_buf_set_name(tree_buf, "NvimTree_1")

assert(#vim.api.nvim_list_wins() == 1, "expected a single window before recovery")

local recovered = landing.recover_from_lonely_tree()

assert(recovered == true, "expected recovery from a lonely NvimTree window")

local filetypes = {}
for _, win in ipairs(vim.api.nvim_list_wins()) do
	local buf = vim.api.nvim_win_get_buf(win)
	filetypes[vim.api.nvim_get_option_value("filetype", { buf = buf })] = true
end

assert(#vim.api.nvim_list_wins() == 1, "expected landing recovery to reuse the existing window")
assert(filetypes.NvimTree ~= true, "expected NvimTree window to be replaced")
assert(filetypes.minintro == true, "expected landing page window to be shown")

vim.cmd("qa!")

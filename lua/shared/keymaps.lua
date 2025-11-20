local M = {}

function M.setup()
  if M.loaded then
    return
  end
  M.loaded = true

  -- 共享基础键位，供 VSCode 与纯 Neovim 共用
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  vim.cmd("nmap j gj")
  vim.cmd("nmap k gk")

  vim.cmd("vmap j gj")
  vim.cmd("vmap k gk")

  -- 清除搜索高亮
  map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
  end, { expr = true, desc = "Escape and Clear Search" })

  map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

  -- 行首行尾移动
  map("n", "H", "^", { desc = "Go to beginning of line" })
  map("n", "L", "$", { desc = "Go to end of line" })
  map("v", "H", "^", { desc = "Go to beginning of line" })
  map("v", "L", "$", { desc = "Go to end of line" })

  -- 延迟重新设置 H/L 映射，确保覆盖插件的默认映射
  vim.defer_fn(function()
    map("n", "H", "^", { desc = "Go to beginning of line" })
    map("n", "L", "$", { desc = "Go to end of line" })
    map("v", "H", "^", { desc = "Go to beginning of line" })
    map("v", "L", "$", { desc = "Go to end of line" })
  end, 200)

  -- 快速退出插入模式
  map("i", "jk", "<Esc>", opts)
  map("i", "kj", "<Esc>", opts)

  -- 如果是 VSCode 环境，加载 VSCode 专属键映射
  if vim.g.vscode then
    require("vscode-nvim.keymaps").setup()
  end
end

-- 自动执行设置
M.setup()

return M

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local buf = ev.buf
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
    end

    -- gh：若光标处有诊断则弹出诊断浮窗，否则走 hover
    map("gh", function()
      local pos = vim.api.nvim_win_get_cursor(0)
      local diags = vim.diagnostic.get(0, { lnum = pos[1] - 1, col = pos[2] })
      if #diags > 0 then
        vim.diagnostic.open_float(nil, { focus = false })
      else
        vim.lsp.buf.hover()
      end
    end, "Hover or Diagnostics")
  end,
})

-- 纯 Neovim 下，确保 H/L 永远是行首/行尾（避免被其他插件覆盖）
-- 绑定 H/L 为行首/行尾
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to beginning of line", silent = true })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line", silent = true })

-- 诊断跳转快捷键
vim.keymap.set("n", "<leader>dj", function()
  vim.diagnostic.goto_next()
end, { desc = "Next Diagnostic" })

vim.keymap.set("n", "<leader>dk", function()
  vim.diagnostic.goto_prev()
end, { desc = "Previous Diagnostic" })

-- 在下一行添加空行但不进入插入模式
vim.keymap.set("n", "<C-CR>", "o<Esc>", { desc = "Add empty line below", silent = true })

-- 文件路径复制快捷键
vim.keymap.set("n", "<leader>rr", function()
  local relative_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  vim.fn.setreg("+", relative_path)
  print("Copied relative path: " .. relative_path)
end, { desc = "Copy Relative Path" })

vim.keymap.set("n", "<leader>ra", function()
  local absolute_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
  vim.fn.setreg("+", absolute_path)
  print("Copied absolute path: " .. absolute_path)
end, { desc = "Copy Absolute Path" })

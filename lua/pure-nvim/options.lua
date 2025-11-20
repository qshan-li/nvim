require("shared.options").setup()

-- Pure Neovim 字体配置
if not vim.g.vscode then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h13"
end

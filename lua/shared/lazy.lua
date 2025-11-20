local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 根据环境设置不同的插件规范
local spec = {}

-- 添加 LazyVim 并导入其插件
table.insert(spec, { "LazyVim/LazyVim", import = "lazyvim.plugins" })

-- 导入共享插件配置
table.insert(spec, { import = "shared.plugins" })

-- 如果是 VSCode 环境，添加 VSCode 专属插件
if vim.g.vscode then
  table.insert(spec, { import = "vscode-nvim.plugins" })
-- 如果不是 VSCode 环境，添加纯 Neovim 插件
else
  table.insert(spec, { import = "pure-nvim.plugins" })
end

require("lazy").setup({
  spec = spec,
  defaults = {
    -- 默认情况下，只有 LazyVim 插件会被延迟加载。你的自定义插件会在启动时加载。
    -- 如果你清楚自己在做什么，可以将其设置为 `true` 让所有自定义插件默认延迟加载。
    lazy = false,
    -- 建议暂时将 version=false，因为很多支持版本控制的插件
    -- 都有过时的版本，这可能会破坏你的 Neovim 安装。
    version = false, -- 始终使用最新的 git 提交
    -- version = "*", -- 尝试安装支持 semver 的插件的最新稳定版本
  },
  install = { colorscheme = { "kanagawa", "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- 定期检查插件更新
    notify = false, -- 更新时通知
  }, -- 自动检查插件更新
  performance = {
    rtp = {
      -- 禁用一些 rtp 插件
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- 环境特定的配置
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = false, -- 禁用配置变更自动重新加载
    notify = false,
  },
})

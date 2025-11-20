-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
      require("nvim-treesitter.install").compilers = { "clang" }
    end
  end,
  opts = {
    ensure_installed = {
      "vim",
      "vimdoc",
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "rust",
      "tsx",
      "typescript",
      "yaml",
      "vue",
      "java",
      "go"
    },
  },
}

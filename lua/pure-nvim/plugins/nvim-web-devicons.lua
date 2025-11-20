return {
  "nvim-tree/nvim-web-devicons",
  opts = {
    color_icons = false,
    default = true,
  },
  config = function(_, opts)
    require("nvim-web-devicons").setup(opts)

    local gray = "#808080"
    vim.api.nvim_set_hl(0, "DevIconDefault", { fg = gray, nocombine = true })
    -- snacks.nvim explorer fallback highlight (if present)
    vim.api.nvim_set_hl(0, "SnacksExplorerIcon", { fg = gray, nocombine = true })
  end,
}

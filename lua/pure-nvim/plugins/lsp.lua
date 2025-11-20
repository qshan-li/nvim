return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.tsserver = vim.tbl_deep_extend("force", opts.servers.tsserver or {}, {
        settings = {
          typescript = { format = { enable = false } },
          javascript = { format = { enable = false } },
        },
      })

      opts.servers.eslint = vim.tbl_deep_extend("force", opts.servers.eslint or {}, {
        settings = {
          workingDirectory = { mode = "auto" },
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "ts_ls",
        "eslint",
      })
    end,
  },
}

return {
  {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = "FloatermToggle",
    keys = {
      {
        [[<C-/>]],
        "<cmd>FloatermToggle<cr>",
        mode = { "n", "t" },
        desc = "Floaterm Toggle",
      },
      {
        [[<C-_>]],
        "<cmd>FloatermToggle<cr>",
        mode = { "n", "t" },
        desc = "Floaterm Toggle",
      },
    },
  }
}

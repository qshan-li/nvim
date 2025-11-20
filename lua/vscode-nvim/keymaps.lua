local M = {}

function M.setup()
  local map = vim.keymap.set
  local vscode = require("vscode")

  map("n", "<Space>", function()
    vscode.action("whichkey.show")
  end, { desc = "Show WhichKey" })

  map("v", "<Space>", function()
    vscode.action("whichkey.show")
  end, { desc = "Show WhichKey" })

  map("n", "<leader>e", function()
    vscode.call("workbench.action.toggleSidebarVisibility")
  end, { desc = "Toggle Explorer" })

  map("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
  end, { desc = "Quick Open" })

  map("n", "<leader>rn", function()
    vscode.action("editor.action.rename")
  end, { desc = "Rename Symbol" })

  map("n", "<leader>ca", function()
    vscode.action("editor.action.quickFix")
  end, { desc = "Quick Fix" })

  map("n", "<leader>f", function()
    vscode.action("editor.action.formatDocument")
  end, { desc = "Format Document" })

  map("n", "<leader>sv", function()
    vscode.action("workbench.action.splitEditor")
  end, { desc = "Split Vertical" })

  map("n", "<leader>sh", function()
    vscode.action("workbench.action.splitEditorOrthogonal")
  end, { desc = "Split Horizontal" })

  map("n", "<leader>q", function()
    vscode.action("workbench.action.closeActiveEditor")
  end, { desc = "Close Editor" })

  map("n", "<leader>u", function()
    vscode.action("editor.action.referenceSearch.trigger")
  end, { desc = "Go to References" })

  map("n", "]d", function()
    vscode.action("editor.action.marker.next")
  end, { desc = "Next Marker in Files" })

  map("n", "[d", function()
    vscode.action("editor.action.marker.prev")
  end, { desc = "Previous Marker in Files" })


  -- map("n", "<leader>dj", function()
  --   vscode.action("editor.action.marker.next")
  -- end, { desc = "Next Marker in Files" })

  -- map("n", "<leader>dk", function()
  --   vscode.action("editor.action.marker.prev")
  -- end, { desc = "Previous Marker in Files" })

  map("n", "<leader>rr", function()
    vscode.action("copyRelativeFilePath")
  end, { desc = "Copy Relative File Path" })

  map("n", "<leader>ra", function()
    vscode.action("copyFilePath")
  end, { desc = "Copy Absolute File Path" })

  map("n", "<C-/>", function()
    vscode.action("editor.action.commentLine")
  end, { desc = "Toggle Line Comment" })

  map("v", "<C-/>", function()
    vscode.action("editor.action.commentLine")
  end, { desc = "Toggle Line Comment" })

  map("n", "za", function()
    vscode.action("editor.toggleFold")
  end, { desc = "Toggle Code Fold" })

  -- 诊断跳转组合键
  -- map("n", "]d", function()
  --   vscode.call("editor.action.marker.next")
  -- end, { desc = "Next Diagnostic" })

  -- map("n", "[d", function()
  --   vscode.call("editor.action.marker.prev")
  -- end, { desc = "Previous Diagnostic" })
end

return M

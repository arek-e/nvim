---@type MappingsTable
local M = {}

local function cmd(command)
  return table.concat { "<cmd>", command, "<cr>" }
end

local function toggle_diagnostics()
  local diagnostics_on = require("lsp_lines").toggle()
  if diagnostics_on then
    vim.diagnostic.config {
      virtual_text = false,
    }
  else
    vim.diagnostic.config {
      virtual_text = { spacing = 4, prefix = " ●" },
    }
  end
end

M.disabled = {
  n = {
    -- line numbers
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
  },
  i = {
    ["<C-e"] = "",
  },
}

vim.g.copilot_no_tab_map = true
M.copilot = {
  i = {
    ["<C-e>"] = { 'copilot#Accept("<CR>")', "accept copilot suggestion", opts = { expr = true } },
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}
M.code_runner = {
  n = {
    ["<leader>r"] = {cmd "RunCode", opts = {noremap = true, silent = false}},
    ["<leader>rf"] = {cmd "RunFile", opts = {noremap = true, silent = false}},
    ["<leader>rft"] = {cmd "RunFile tab", opts = {noremap = true, silent = false}},
    ["<leader>rp"] = {cmd "RunProject", opts = {noremap = true, silent = false}},
    ["<leader>rc"] = {cmd "RunClose", opts = {noremap = true, silent = false}},
    ["<leader>crf"] = {cmd "CRFileType", opts = {noremap = true, silent = false}},
    ["<leader>crp"] = {cmd "CRProjects", opts = {noremap = true, silent = false}},
  }
}

M.session = {
  n = {
    ["<leader>ss"] = { cmd "SessionSave", "save session" },
    ["<leader>sl"] = { cmd "SessionLoad", "load session" },
  },
}

M.lazy = {
  n = {
    ["<leader>pu"] = { cmd "Lazy update", "lazy update" },
    ["<leader>pi"] = { cmd "Lazy install", "lazy install " },
  },
}

M.navigation = {
  n = {
    -- hop.nvim
    ["f"] = { cmd "HopWordAC", "hop words after cursor" },
    ["F"] = { cmd "HopWordBC", "hop words before cursor" },
    ["t"] = { cmd "HopPatternAC", "hop patterns after cursor" },
    ["T"] = { cmd "HopPatternBC", "hop patterns before cursor" },
    -- flybuf.nvim
    ["<leader>j"] = { cmd "FlyBuf", "open FlyBuf" },
  },
}

M.lspsaga = {
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["K"] = { cmd "Lspsaga hover_doc", "lsp saga hover" },
    ["[e"] = { cmd "Lspsaga diagnostic_jump_next", "lsp saga diagnostic next" },
    ["]e"] = { cmd "Lspsaga diagnostic_jump_prev", "lsp saga diagnostic previous" },
    ["ga"] = { cmd "Lspsaga code_action", "lsp saga " },
    ["gd"] = { cmd "Lspsaga peek_definition", "lsp saga " },
    ["gr"] = { cmd "Lspsaga rename", "lsp saga " },
    ["gh"] = { cmd "Lspsaga lsp_finder", "lsp saga " },
    ["<leader>o"] = { cmd "Lspsaga outline", "lsp saga " },
    ["<leader>dw"] = { cmd "Lspsaga show_workspace_diagnostics", "lsp saga " },
    ["<leader>db"] = { cmd "Lspsaga show_buf_diagnostics", "lsp saga " },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
  },
}

M.comment = {
  plugin = true,
  -- toggle comment in both modes
  n = {
    ["gcc"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["gcc"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.diagnostics = {
  n = {
    ["<leader>ll"] = { toggle_diagnostics, "toggle LSP lines" },
  },
}

M.git = {
  n = {
    ["<leader>gg"] = {
      function()
        local term = require("nvterm.terminal").new "float"
        vim.api.nvim_chan_send(term.job_id, "lazygit\n")
      end,
      "open Lazygit",
    },
  },
}

return M

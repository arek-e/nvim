---@type MappingsTable
local M = {}

local function cmd(command)
  return table.concat({ "<cmd>", command, "<cr>" })
end

local function toggle_diagnostics()
  local diagnostics_on = require("lsp_lines").toggle()
  if diagnostics_on then
    vim.diagnostic.config({
      virtual_text = false,
    })
  else
    vim.diagnostic.config({
      virtual_text = { spacing = 4, prefix = " ●" },
    })
  end
end

M.disabled = {
  n = {
    -- line numbers
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
  },
  i = {
    ["<C-e"] = ""
  }

}


vim.g.copilot_no_tab_map = true
M.copilot = {
  plugin = true,
  i = {
    ["<C-e>"] = { 'copilot#Accept("<CR>")', "accept copilot suggestion", opts = { expr = true }},
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.mini = {
  n = {
    ["<leader>os"] = {cmd "lua require('mini.sessions').select()", "open sessions" }
  }
}

M.flutter = {
  -- plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

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

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
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
    ["<leader>ll"] = {toggle_diagnostics, "toggle LSP lines"}
  }
}

M.git = {
  n = {
  ["<leader>gg"] = {
    function()
      local term = require("nvterm.terminal").new("float")
      vim.api.nvim_chan_send(term.job_id, "lazygit\n")
    end,
    "open Lazygit",
  },
}
}

return M

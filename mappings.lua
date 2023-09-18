---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>b"] =  "",
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger",
    },
  },
}

M.bufremove = {
  plugin = true,
  n = {
    ["<leader>bd"] = {
      function()
        require("mini.bufremove").delete(0, false)
      end,
      desc = "Delete Buffer",
    },
    ["<leader>bD"] = {
      function()
        require("mini.bufremove").delete(0, true)
      end,
      desc = "Delete Buffer (Force)",
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    ["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    ["<leader>xL"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    ["<leader>xQ"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    ["[q"] = {
      function()
        if require("trouble").is_open() then
          require("trouble").previous { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    ["]q"] = {
      function()
        if require("trouble").is_open() then
          require("trouble").next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}

M.todocomments = {
  plugin = true,
  n = {
    ["]t"] = {
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    ["[t"] = {
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    ["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    ["<leader>xT"] = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    ["<leader>st"] = { "<cmd>TodoTelescope<cr>", desc = "Todo" },
    ["<leader>sT"] = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}

M.flash = {
  plugin = true,
  n = {
    ["s"] = {
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    ["S"] = {
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
  c = {
    ["<c-s>"] = {
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
  o = {
    ["s"] = {
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    ["S"] = {
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },

    ["r"] = {
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },

    ["R"] = {
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
  },

  x = {
    ["R"] = {
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
  },
}

M.notify = {
  plugin = true,
  n = {
    ["<leader>un"] = {
      function()
        require("notify").dismiss { silent = true, pending = true }
      end,
      desc = "Dismiss all Notifications",
    },
  },
}

M.persistence = {
  plugin = true,
  n = {
    ["<leader>qs"] = {
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    ["<leader>ql"] = {
      function()
        require("persistence").load { last = true }
      end,
      desc = "Restore Last Session",
    },
    ["<leader>qd"] = {
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}

return M

---@type MappingsTable
local M = {}

local function cmd(command)
  return table.concat { "<cmd>", command, "<cr>" }
end

local function l(command)
  return table.concat { "<cmd>lua ", command, "<cr>" }
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

M.dap = {
  n = {
    ["<leader>dr"] = { l "require('go.dap').run()", "run" },
    ["<leader>dc"] = { l "require('dap').continue()", "continue" },
    ["<leader>dn"] = { l "require('dap').step_over()", "step over" },
    ["<leader>ds"] = { l "require('dap').step_into()", "step into" },
    ["<leader>do"] = { l "require('dap').step_out()", "step out" },
    ["<leader>dS"] = {
      function()
        require("go.dap").stop(true)
      end,
      "stop debug session",
    },
    ["<leader>du"] = { l "require('dap').up()", "up" },
    ["<leader>dD"] = { l "require('dap').down()", "down" },
    ["<leader>dC"] = { l "require('dap').run_to_cursor()", "run to cursor" },
    ["<leader>db"] = { l "require('dap').toggle_breakpoint()", "toggle breakpoint" },
    ["<leader>dP"] = { l "require('dap').pause()", "pause" },
    -- Dap UI
    ["<leader>dp"] = {
      function()
        require("dapui").eval()
      end,
      "eval",
    },
    ["<leader>dK"] = {
      function()
        require("dapui").float_element()
      end,
      "float element",
    },
    ["<leader>dB"] = {
      function()
        require("dapui").float_element('break')
      end,
      "float breakpoints",
    },
    ["<leader>dR"] = {
      function()
        require("dapui").float_element "repl"
      end,
      "float repl",
    },
    ["<leader>dO"] = {
      function()
        require("dapui").float_element "scopes"
      end,
      "float scopes",
    },
    ["<leader>da"] = {
      function()
        require("dapui").float_element "stacks"
      end,
      "float stacks",
    },
    ["<leader>dw"] = {
      function()
        require("dapui").float_element "watches"
      end,
      "float watches",
    },
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

local function ft_runFile()
  local filetype = vim.bo.filetype
  if filetype == "dart" then
    vim.cmd("FlutterRun")
  else
    vim.cmd("RunFile")
  end
end
M.code_runner = {
  n = {
    ["<leader>r"] = { cmd "RunCode", opts = { noremap = true, silent = false } },
    ["<leader>rf"] = { ft_runFile, "Run file", opts = { noremap = true, silent = false } },
    ["<leader>rft"] = { cmd "RunFile tab", opts = { noremap = true, silent = false } },
    ["<leader>rp"] = { cmd "RunProject", opts = { noremap = true, silent = false } },
    ["<leader>rc"] = { cmd "RunClose", opts = { noremap = true, silent = false } },
    ["<leader>crf"] = { cmd "CRFileType", opts = { noremap = true, silent = false } },
    ["<leader>crp"] = { cmd "CRProjects", opts = { noremap = true, silent = false } },
  },
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
    ["ga"] = { cmd "Lspsaga code_action", "code action " },
    ["gd"] = { cmd "Lspsaga peek_definition", "peek definition " },
    ["gr"] = { cmd "Lspsaga rename", "rename " },
    ["gh"] = { cmd "Lspsaga lsp_finder", "lsp finder " },
    ["<leader>o"] = { cmd "Lspsaga outline", "outline" },
    ["<leader>tw"] = { cmd "Lspsaga show_workspace_diagnostics", "workspace diagnostics" },
    ["<leader>tb"] = { cmd "Lspsaga show_buf_diagnostics", "workspace diagnostics" },

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

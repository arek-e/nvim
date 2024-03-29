local M = {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  name = 'telescope',
  cmd = { "Telescope" },

  dependencies = {
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-z.nvim" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-symbols.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "natecraddock/telescope-zf-native.nvim" },
	{ "desdic/telescope-rooter.nvim" },
	{
		'nvim-telescope/telescope-frecency.nvim',
		-- dependencies = { 'kkharji/sqlite.lua' }
	},
	{
		'danielfalk/smart-open.nvim',
		dependencies = { 'tami5/sqlite.lua' }
	}
  },
}

function M.project_files(opts)
  opts = opts or {}
  opts.show_untracked = true
  if vim.loop.fs_stat(".git") then
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end

function M.config()
  -- local actions = require("telescope.actions")
  -- local trouble = require("trouble.providers.telescope")

  local telescope = require("telescope")
  local borderless = true
  telescope.setup({
    extensions = {
			["fzf"] = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			["rooter"] = {
				enable = true,
				patterns = { ".git", ".project" },
				debug = false
			},
			--[[ ["zf-native"] = {
				-- options for sorting file-like items
				file = {
					enable = true,
					highlight_results = true,
					match_filename = true,
				},
				generic = {
					enable = true,
					highlight_results = true,
					match_filename = false,
				},
			} ]]
    },
    defaults = {
			mappings = {
				i = {
					['<esc>'] = require('telescope.actions').close,
					['<c-j>'] = require('telescope.actions').move_selection_next,
					['<c-k>'] = require('telescope.actions').move_selection_previous,
					['<C-n>'] = require('telescope.actions').cycle_history_next,
					['<C-p>'] = require('telescope.actions').cycle_history_prev,
				},

				n = {
					['<esc>'] = require('telescope.actions').close,
					-- ['<C-i>'] = my_cool_custom_action,
				},
			},-- mappings = { i = { ["<esc>"] = actions.close } },
      -- vimgrep_arguments = {
      --   'rg',
      --   '--color=never',
      --   '--no-heading',
      --   '--with-filename',
      --   '--line-number',
      --   '--column',
      --   '--smart-case'
      -- },
      -- prompt_position = "bottom",
      prompt_prefix      = "  ",
      selection_caret    = "⮫ ",
      entry_prefix       = " ",
      initial_mode       = "insert",
      selection_strategy = "reset",
      sorting_strategy   = "descending",
      layout_strategy    = "horizontal",
      layout_defaults    = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
      },
      -- file_sorter = require"telescope.sorters".get_fzy_file
      -- file_ignore_patterns = {},
      -- generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      -- shorten_path = true,
      winblend = borderless and 0 or 10,
      -- width = 0.7,
      -- preview_cutoff = 120,
      -- results_height = 1,
      -- results_width = 0.8,
      -- border = false,
      -- color_devicons = true,
      -- use_less = true,
      -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

      -- -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
  })

  telescope.load_extension("frecency")
  -- telescope.load_extension("fzf")
  telescope.load_extension("z")
  telescope.load_extension("file_browser")
  telescope.load_extension("project")
  telescope.load_extension("zf-native")
  telescope.load_extension("rooter")
  require"telescope".load_extension("smart_open")
end

function M.init()
  --[[ vim.keymap.set("n", "<leader>fo", function()
    require("plugins.telescope").git_files()
  end, { desc = "Find File" })
  vim.keymap.set("n", "<leader>fd", function()
    require("telescope.builtin").git_files({ cwd = "~/dot" })
  end, { desc = "Find Dot File" })
  vim.keymap.set("n", "<leader>fz", function()
    require("telescope").extensions.z.list({ cmd = { vim.o.shell, "-c", "zoxide query -ls" } })
  end, { desc = "Find Zoxide" })
  vim.keymap.set("n", "<leader>pp", function()
    require("telescope").extensions.project.project({})
  end, { desc = "Find Project" }) ]]
end

return M

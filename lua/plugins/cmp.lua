local M = {
	"hrsh7th/nvim-cmp",
	disable = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		'rafamadriz/friendly-snippets',
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-path",
		-- "hrsh7th/cmp-buffer",
		"ve5li/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		'davidsierradz/cmp-conventionalcommits',
		'dcampos/cmp-emmet-vim',
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
		"hrsh7th/cmp-cmdline",
		"dmitmel/cmp-cmdline-history",
	},
}

function M.config()
	local cmp     = require('cmp')
	-- local types   = require('cmp.types')
	-- local luasnip = require('luasnip')

	-- local function check_backspace()
	-- 	local col = vim.fn.col '.' - 1
	-- 	return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
	-- end

	-- local feedkeys = vim.fn.feedkeys
	-- local replace_termcodes = vim.api.nvim_replace_termcodes
	-- local backspace_keys = replace_termcodes('<tab>', true, true, true)
	-- local snippet_next_keys = replace_termcodes('<plug>luasnip-expand-or-jump', true, true, true)
	-- local snippet_prev_keys = replace_termcodes('<plug>luasnip-jump-prev', true, true, true)
	-- local mapping = cmp.mapping

	-- local has_words_before = function()
	-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
	-- end

	local icons = {
		Text     = ' ' , Method = 'ƒ ' , Function  = ' ' , Constructor = ' ' , Field         = ' ' ,
		Variable = ' ' , Class  = ' ' , Interface = ' ' , Module      = ' ' , Property      = ' ' ,
		Unit     = ' ' , Value  = ' ' , Enum      = ' ' , Keyword     = ' ' , Snippet       = ' ' ,
		color    = ' ' , File   = ' ' , Reference = ' ' , Folder      = ' ' , Enummember    = ' ' ,
		Constant = ' ' , Struct = 'פּ ' , Event     = ' ' , Operator    = ' ' , Typeparameter = ' ' ,
    Array    = " " , Boolean= " " , Namespace = " " , Null        = "ﳠ " , Number        = " " ,
	}

	cmp.setup({
    --[[ completion = {
      completeopt = "menu,menuone,noinsert",
    }, ]]
		snippet = {
			expand = function(args) require('luasnip').lsp_expand(args.body) end,
		},
		experimental = {
      ghost_text = { hl_group = "CmpGhostText" },
		},
		performance = {
			trigger_debounce_time = 50
		},
		window = {
			completion    = cmp.config.window.bordered({
				winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
				-- scrollbar = false,
				scrollbar = {
					thumb_char = "│",
					position = "edge",
				},
			}),
			documentation = cmp.config.window.bordered({ winhighlight = 'Normal:CmpDocNormal' }),
		},
		view = {
			entries = "custom", -- can be "custom", "wildmenu" or "native"
			winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
		},
		sources = {
			-- { name = 'nvim_lsp_signature_help' },
			-- { name = 'luasnip'  },
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lua' },
			{ name = 'path'     },
			{ name = 'luasnip'  },
			{ name = 'conventionalcommits' },
			-- { name = 'emmet_vim' },
			{ name = 'emoji'  },
			{
				name = 'buffer',
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end
				},
			},
			{ name = 'conventionalcommits' },
		},
		formatting = {
			-- fields = { 'kind', 'abbr'},
			-- fields = { 'kind', 'abbr', 'menu'},
			fields = { 'abbr', 'kind'},
			format = require('lspkind').cmp_format({
				preset        = 'codicons',
				ellipsis_char = '...',
				mode          = 'symbol_text',
				symbol_map    = icons,
				maxwidth      = 50,
				before = function (entry, vim_item)
					vim_item.menu = ({
						luasnip     = 'SNP',
						nvim_lsp    = 'LSP',
						nvim_lua    = 'NVM',
						buffer      = 'BUF',
						path        = 'PATH',
						cmp_tabnine = 'T9',
          })[entry.source.name]
          return vim_item
        end
      })
    },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<Left>"] = cmp.mapping.select_prev_item(),
      ["<Right>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(),
      { "i", "c" }),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true
      })
    },
  })

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	local cmdline_view = {
		entries = {
			name = 'wildmenu',
			separator = ' • ',
		},
		winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
	}

	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		view = cmdline_view,
		sources = {
			{ name = 'buffer' },
			{ name = "cmdline_history" },
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		view = cmdline_view,
		-- sources = cmp.config.sources({
		sources = {
			{ name = "cmdline_history" },
			{ name = "cmdline" },
			{ name = "path" },
			{ name = "noice_popupmenu" },
		},
	})

	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
end

return M


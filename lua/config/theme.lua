local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then return end

catppuccin.setup{
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.5,
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true,
    },

}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

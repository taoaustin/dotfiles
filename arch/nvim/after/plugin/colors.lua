--vim.g.material_style = "darker"
--vim.g.sonokai_style = "default"
--vim.cmd 'colorscheme material'
--vim.cmd 'colorscheme oh-lucy-evening'
--vim.cmd 'colorscheme omni'
vim.cmd 'colorscheme melange'

vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE' --TRANSPARENT BG
vim.cmd 'highlight EndOfBuffer guibg=None ctermbg=None' -- TRANSPARENT EOB

require("material").setup({
    lualine_style = 'stealth'
})

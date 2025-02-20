vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require("config.lazy")
require("keymap")
vim.opt.clipboard = "unnamedplus"

-- Navigate to previous dir
vim.keymap.set("n", "<space>pv", function() vim.cmd.Ex() end)

-- Auto-format on save
local augroup = vim.api.nvim_create_augroup("AutoFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
        vim.lsp.buf.format({ async = false }) -- Synchronous formatting before save
    end,
    desc = "Auto format buffer on save",
})

-- Set a semi-transparent effect for visual mode (using lighter background)
vim.api.nvim_set_hl(0, "Visual", { bg = "#cccccc", fg = "#000000" })

--Set cursor style to block in insert mode

vim.opt.guicursor = "i:block"

--dont fold for kitty.conf
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "kitty.conf",
    callback = function()
        vim.opt_local.foldenable = false
    end,
})

--annoying save prompt

vim.opt.shortmess:append("c")

--tab spacing

-- Use spaces instead of tabs
vim.o.expandtab = true

-- Set the width of each indentation level
vim.o.shiftwidth = 4 -- Change 4 to whatever width you prefer

-- Set the width of a tab character
vim.o.tabstop = 4 -- Ensure it matches shiftwidth if you want consistency

-- Keep auto-indents aligned with shiftwidth
vim.o.smartindent = true

--highlights for completions

-- Deprecated (gray) – uses a muted comment color with strikethrough
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = "#1f2335", fg = "#565f89", strikethrough = true })

-- Match (blue) – for matching text in completions
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = "#1f2335", fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' })

-- Variable / Interface / Text (cyan) – using a light cyan for variables and similar items
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = "#1f2335", fg = "#7dcfff" })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })

-- Function / Method (purple) – functions get a purple tone
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = "#1f2335", fg = "#bb9af7" })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })

-- Keyword / Property / Unit (light gray) – for keywords and similar completion types
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = "#1f2335", fg = "#a9b1d6" })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

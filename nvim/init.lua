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

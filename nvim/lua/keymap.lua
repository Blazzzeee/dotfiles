--navigate files like a pro

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

--opening multiple panes
vim.keymap.set('n', '<A-v>', ':vsp<CR>:wincmd w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-h>', ':sp<CR>:wincmd w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-q>', ':q<CR>', { noremap = true, silent = true })
--navigation in panes
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>', { noremap = true, silent = true })
--reszie panes
vim.keymap.set('n', '<A-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })


-- C/C++ compilation stuff


vim.api.nvim_create_user_command('Run', function()
	local filename = vim.fn.expand('%:p')       -- Get absolute path of the current file
	local output = vim.fn.fnamemodify(filename, ':r') -- Remove .c extension safely

	-- Open a vertical split and execute the compiled program
	vim.cmd('vsplit | terminal sh -c "gcc ' ..
	vim.fn.shellescape(filename) ..
	' -o ' .. vim.fn.shellescape(output) .. ' && ' .. vim.fn.shellescape(output) .. '"')
end, {})

vim.api.nvim_set_keymap('n', '<leader>r', ':Run<CR>', { noremap = true, silent = true })

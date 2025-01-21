return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim", -- Ensure this is installed as a dependency
		},
		config = function()
			-- Keymaps for Telescope
			local builtin = require('telescope.builtin')

			vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', 'C-p', builtin.git_files, { desc = 'Telescope find git files' })

			vim.keymap.set('n', '<leader>ps', function()
				require('telescope.builtin').live_grep({ default_text = vim.fn.input("Grep > ") })
			end, { desc = 'Telescope live grep' }) -- Find git files            -- Setup Telescope and ui-select extension
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {} -- Theme settings for ui-select
					}
				}
			}

			-- Load the ui-select extension after telescope setup
			require("telescope").load_extension("ui-select")
		end,
	},
}

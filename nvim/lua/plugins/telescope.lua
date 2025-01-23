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

			-- Keymaps for basic Telescope functions
			vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', 'C-p', builtin.git_files, { desc = 'Telescope find git files' })

			-- Correct way to map live_grep_args
			vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = 'Telescope live grep' })

			-- Setup Telescope
			require("telescope").setup {
				extensions = {
					-- ui-select extension settings
					["ui-select"] = {
						require("telescope.themes").get_dropdown {} -- Theme settings for ui-select
					}
				}
			}

			-- Load the extensions after Telescope setup
			require("telescope").load_extension("ui-select")
		end,
	},
}

-- lua/plugins/harpoon.lua
return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("harpoon").setup({
            -- Example setup options, adjust as needed
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = { "harpoon" },
            },
        })

        -- Optional: Keybindings for Harpoon
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        -- Add files to Harpoon
        map("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", opts)

        -- Open Harpoon menu

        map("n", "<S-o>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
        map("n", "<S-h>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
        map("n", "<S-j>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
        map("n", "<S-k>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
        map("n", "<S-l>", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)
    end,
}

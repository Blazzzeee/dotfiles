return {
    "nvim-lualine/lualine.nvim",
    config = function()
        -- Custom function to display LSP client names for the current buffer
        local function lsp_client()
            local msg = "No Active LSP"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_active_clients()
            if not clients or vim.tbl_isempty(clients) then
                return msg
            end

            local client_names = {}
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    table.insert(client_names, client.name)
                end
            end

            if #client_names > 0 then
                return table.concat(client_names, ", ")
            else
                return msg
            end
        end

        local M = {}
        M.theme = function()
            local colors = {
                darkgray = "#16161d",
                gray = "#727169",
                innerbg = nil,
                outerbg = "#16161D",
                normal = "#7e9cd8",
                insert = "#98bb6c",
                visual = "#ffa066",
                replace = "#e46876",
                command = "#e6c384",
            }
            return {
                inactive = {
                    a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                visual = {
                    a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                replace = {
                    a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                normal = {
                    a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                insert = {
                    a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
                command = {
                    a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
                    b = { fg = colors.gray, bg = colors.outerbg },
                    c = { fg = colors.gray, bg = colors.innerbg },
                },
            }
        end

        local custom_material = M
        require("lualine").setup {
            options = {
                theme = custom_material.theme(),
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {},
                globalstatus = false,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {},
                lualine_x = { "filetype" },
                lualine_y = { "filename" },
                lualine_z = { lsp_client },
            },
            inactive_sections = {
            },
            tabline = {},
            extensions = { "fugitive", "oil", "mason", "lazy" },


        }
    end,
}

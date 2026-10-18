return{
    "nvim-telescope/telescope.nvim",

    version = "*",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}
    },

    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = {"node_modules/", "Library/"}
            }
        })

        local builtin = require('telescope.builtin')
        -- Search by name for files
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Telescope find files"})
        -- Finds git fils by search
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        -- Finds filee by word
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        -- Getting all thee help files for Neovim and Lazy
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}

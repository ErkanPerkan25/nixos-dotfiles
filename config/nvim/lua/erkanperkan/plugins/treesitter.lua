return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch="main",
        lazy = false,
        build = ":TSUpdate",
        config = function ()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                    "jsdoc", "bash", "query"
                },

                -- main branch no longer auto-enables highlighting/indent via setup(),
                -- so we do it ourselves per-filetype.
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = {
                        "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                        "javascriptreact", "typescriptreact", "bash",
                    },
                    callback = function()
                        -- pcall in case a parser isn't installed yet
                        vim.treesitter.start()
                        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end,
                })
            })

        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false, -- Enable multiwindow support.
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 10, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end
    }
}

function ColorMyTheme(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)
    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = false,
                styles = {
                    italic = false,
                },
            })

            ColorMyTheme();
        end
    },

    {
        'Mofiqul/dracula.nvim',
        name="dracula",
        config = function ()
            require("dracula").setup({
            })

            ColorMyTheme("dracula")
        end
    },

    {
         "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            --ColorMyTheme("tokyonight")
        end
    },


    {
      'sainnhe/gruvbox-material',
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_transparent_background = 0
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_foreground = "original"
        vim.cmd.colorscheme('gruvbox-material')
        --ColorMyTheme("gruvbox-material")
      end
    },
}

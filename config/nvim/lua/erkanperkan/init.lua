require("erkanperkan.set")
require("erkanperkan.lazy")

local augroup = vim.api.nvim_create_augroup
local erkanperkan_group = augroup("erkanperkan", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
    group = erkanperkan_group,
    callback = function (e)
        local opts = {buffer = e.buf}
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end)
        vim.keymap.set("n", "E", function () vim.diagnostic.open_float() end)
    end
})

vim.o.background = "dark" -- "dark" or "light" color mode

vim.o.termguicolors = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

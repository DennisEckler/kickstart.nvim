return {
-- {
--   'folke/tokyonight.nvim',
--   priority = 1000, -- Make sure to load this before all the other start plugins.
--   config = function()
--     ---@diagnostic disable-next-line: missing-fields
--     require('tokyonight').setup {
--       styles = {
--         comments = { italic = false }, -- Disable italics in comments
--       },
--     }
--
--     vim.cmd.colorscheme 'tokyonight-night'
--   end,
-- },

-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
{
     'catppuccin/nvim',
     priority = 1000,
     config = function()
       require('catppuccin').setup {}
       vim.cmd.colorscheme 'catppuccin-frappe'
     end,
   },
}

--[[
    NOTE: After understanding a bit more about Lua, you can use:
      - :help lua-guide

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.


  If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

--]]
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/custom` folder
require('lazy').setup({ import = 'plugins' }, {
  change_detection = {
    notify = false,
  },
  {
    ui = {
      -- if you are using a nerd font: set icons to an empty table which will use the
      -- default lazy.nvim defined nerd font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  },
})

--   { -- Collection of various small independent plugins/modules
--     'echasnovski/mini.nvim',
--     config = function()
--       -- Better Around/Inside textobjects
--       --
--       -- Examples:
--       --  - va)  - [V]isually select [A]round [)]paren
--       --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--       --  - ci'  - [C]hange [I]nside [']quote
--       require('mini.ai').setup { n_lines = 500 }
--
--       -- Add/delete/replace surroundings (brackets, quotes, etc.)
--       --
--       -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--       -- - sd'   - [S]urround [D]elete [']quotes
--       -- - sr)'  - [S]urround [R]eplace [)] [']
--       require('mini.surround').setup()
--
--       -- Simple and easy statusline.
--       --  You could remove this setup call if you don't like it,
--       --  and try some other statusline plugin
--       local statusline = require 'mini.statusline'
--       -- set use_icons to true if you have a Nerd Font
--       statusline.setup { use_icons = vim.g.have_nerd_font }
--
--       -- You can configure sections in the statusline by overriding their
--       -- default behavior. For example, here we set the section for
--       -- cursor location to LINE:COLUMN
--       ---@diagnostic disable-next-line: duplicate-set-field
--       statusline.section_location = function()
--         return '%2l:%-2v'
--       end
--
--       -- ... and there is more!
--       --  Check out: https://github.com/echasnovski/mini.nvim
--     end,
--   },
--
--   require 'kickstart.plugins.debug',
--   -- require 'kickstart.plugins.indent_line',
--   -- require 'kickstart.plugins.lint',
--   -- require 'kickstart.plugins.autopairs',
--   -- require 'kickstart.plugins.neo-tree',
--   require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
--
--   -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
--   -- Or use telescope!
--   -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

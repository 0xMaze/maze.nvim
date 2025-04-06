return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local nvimtree = require 'nvim-tree'

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light green
    vim.cmd [[ highlight NvimTreeFolderArrowClosed guifg=#9CCFD8 ]]
    vim.cmd [[ highlight NvimTreeFolderArrowOpen guifg=#9CCFD8 ]]
    vim.cmd [[ highlight NvimTreeFloatBorder guifg=#9CCFD8 ]] -- Add border color matching your arrows

    -- configure nvim-tree
    nvimtree.setup {
      view = {
        width = 35,
        relativenumber = true,
        -- Keep your original side setting as fallback
        side = 'right',
        -- Add floating configuration
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local w_h = 70
            local s_h = 42
            local center_x = (screen_w - w_h) / 2
            local center_y = ((vim.opt.lines:get() - s_h) / 5) - vim.opt.cmdheight:get()
            return {
              relative = 'editor',
              border = 'rounded',
              width = w_h,
              height = s_h,
              row = center_y,
              col = center_x,
            }
          end,
        },
      },
      -- change folder arrow icons (unchanged)
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '', -- arrow when folder is closed
              arrow_open = '', -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for explorer to work well with window splits (unchanged)
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      git = {
        ignore = false,
      },

      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom mappings (unchanged)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, silent = true, nowait = true }
        end
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
        vim.keymap.set('n', '<C-r>', api.tree.change_root_to_node, opts 'Set CWD Here')
        vim.keymap.set('n', '-', api.tree.close, opts 'Close')
      end,
    }

    -- Keep your original toggle keymap
    vim.keymap.set('n', '-', '<cmd>NvimTreeToggle<CR>', { noremap = true })
  end,
}

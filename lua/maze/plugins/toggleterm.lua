return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-`>]], -- Your preferred keybinding (Ctrl + `)
      direction = 'float', -- Always open as a floating terminal
      float_opts = {
        border = 'rounded', -- Rounded borders
        width = function() -- Adjust width (percentage of Neovim's width)
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function() -- Adjust height (percentage of Neovim's height)
          return math.floor(vim.o.lines * 0.7)
        end,
        winblend = 10, -- Slight transparency (optional)
      },
      -- Other settings (optional)
      close_on_exit = true, -- Close terminal when process exits
      auto_scroll = true, -- Auto-scroll to the bottom
    }
  end,
}

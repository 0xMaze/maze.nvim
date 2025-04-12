return {
  'kylechui/nvim-surround',
  version = '*', -- Use latest stable version
  event = 'VeryLazy', -- Load only when needed
  config = function()
    require('nvim-surround').setup {
      -- Optional configuration (defaults work well)
      keymaps = {
        insert = '<C-g>s', -- Insert mode trigger (optional)
        normal = 'ys', -- Normal mode (e.g., `ysiw)`)
        visual = 'S', -- Visual mode (e.g., select text + `S(`)
        delete = 'ds', -- Delete surrounds (e.g., `ds"`)
        change = 'cs', -- Change surrounds (e.g., `cs'(`)
      },
    }
  end,
}

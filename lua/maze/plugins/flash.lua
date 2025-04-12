return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    -- Default 's' key
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },

    -- New custom jump on <leader>j
    {
      '<leader>j',
      mode = { 'n', 'x', 'o' },
      function()
        local Flash = require 'flash'

        ---@param opts Flash.Format
        local function format(opts)
          return {
            { opts.match.label1, 'FlashMatch' },
            { opts.match.label2, 'FlashLabel' },
          }
        end

        Flash.jump {
          search = { mode = 'search' },
          label = {
            after = false,
            before = { 0, 0 },
            uppercase = false,
            format = format,
          },
          pattern = [[\<]],
          action = function(match, state)
            state:hide()
            Flash.jump {
              search = { max_length = 0 },
              highlight = { matches = false },
              label = { format = format },
              matcher = function(win)
                return vim.tbl_filter(function(m)
                  return m.label == match.label and m.win == win
                end, state.results)
              end,
              labeler = function(matches)
                for _, m in ipairs(matches) do
                  m.label = m.label2
                end
              end,
            }
          end,
          labeler = function(matches, state)
            local labels = state:labels()
            for m, match in ipairs(matches) do
              match.label1 = labels[math.floor((m - 1) / #labels) + 1]
              match.label2 = labels[(m - 1) % #labels + 1]
              match.label = match.label1
            end
          end,
        }
      end,
      desc = 'Flash Custom Jump',
    },
    -- Keep other default mappings
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}

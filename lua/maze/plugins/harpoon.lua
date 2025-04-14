return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local harpoon = require 'harpoon'
      local conf = require('telescope.config').values

      harpoon:setup()

      local function show_harpoon_files()
        local items = harpoon:list().items
        local file_paths = vim.tbl_map(function(item)
          return item.value
        end, items)

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon Files',
            finder = require('telescope.finders').new_table {
              results = file_paths,
              entry_maker = function(file_path)
                return {
                  value = file_path,
                  display = vim.fn.fnamemodify(file_path, ':~:.'),
                  ordinal = file_path,
                }
              end,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set(
        'n',
        '<leader>ha',
        function()
          harpoon:list():add()
        end, -- [H]arpoon [A]dd
        { desc = 'Harpoon: Add file' }
      )

      vim.keymap.set(
        'n',
        '<leader>hf',
        show_harpoon_files, -- [H]arpoon [F]iles
        { desc = 'Harpoon: Show files' }
      )

      for i = 1, 4 do
        vim.keymap.set('n', string.format('<leader>%d', i), function()
          harpoon:list():select(i)
        end, { desc = string.format('Harpoon: Jump to mark %d', i) })
      end

      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon: Next file' })

      vim.keymap.set('n', '<C-p>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon: Previous file' })
    end,
  },
}

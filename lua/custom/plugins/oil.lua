return (
  {
    'stevearc/oil.nvim',
    opts = {
      delete_to_trash = true,
      keymaps = {
          ["gy"] = "actions.yank_entry",
      }
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
      config = function()
        require('oil').setup {
          keymaps = {
          ["gy"] = "actions.yank_entry",
          ["<C-s>"] = false,
          }
        }
      end,
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  }
)

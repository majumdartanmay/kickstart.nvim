return (
  {
    "kkoomen/vim-doge",
    lazy = false,
    run = function() vim.fn[":call doge#install()"]() end,
  }
)

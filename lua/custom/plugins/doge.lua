return (
  {
    "kkoomen/vim-doge",
    lazy = false,
    build = function() vim.fn[":call doge#install()"]() end,
  }
)

return {
  { "tpope/vim-surround" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-abolish" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rails" },
  { "tpope/vim-bundler" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-endwise" },
  {
    "tpope/vim-commentary",
    event = "BufReadPre" ,
  },
  { "tpope/vim-dadbod" },
  { "tpope/vim-projectionist" },
  {
    "tpope/vim-dispatch",
    config = function()
      vim.g.dispatch_no_maps = 1
    end,
  },
  { "tpope/vim-dotenv" },
}


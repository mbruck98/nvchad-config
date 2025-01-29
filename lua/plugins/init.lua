return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "xiyaowong/transparent.nvim"
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
            "vim", "lua", "vimdoc",
            "html", "css", "cpp", "c",
            "python","cmake", "bash",
            "awk", "doxygen"
   		},
    },
  },
}

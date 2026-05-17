return {
  -- surround
  {
    "tpope/vim-surround",
  },

  -- repeat support for vim-surround etc.
  {
    "tpope/vim-repeat",
  },

  -- comment out
  {
    "tpope/vim-commentary",
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,

          hide_by_name = {
            ".idea",
            ".vscode",
          },

          never_show = {
            ".git",
            ".DS_Store",
            "node_modules",
            ".gradle",
          },
        },
      },
      window = {
        width = 30,
      },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },

  -- syntax highlight / language parsing
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")

      ts.setup(opts)

      ts.install({
        "bash",
        "css",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "bash",
          "css",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "typescript",
          "vim",
          "yaml",
        },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  }
}


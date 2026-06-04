return {
  "nwiizo/marp.nvim",
  ft = "markdown",
  config = function()
    require("marp").setup {
      -- Optional configuration
      marp_command = "marp", -- default: "marp" (uses marp from PATH)
      browser = nil,         -- auto-detect
      server_mode = false,   -- Use watch mode (-w)
    }
  end,
}

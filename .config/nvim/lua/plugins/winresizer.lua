return {
  "simeji/winresizer",
  keys = {
    { "<C-e>", "<cmd>WinResizerStartResize<cr>", desc = "Start window resize mode" },
  },
  init = function()
    -- Disable the plugin's default mapping since loading is controlled via lazy.nvim keys
    vim.g.winresizer_start_key = ""
  end,
}

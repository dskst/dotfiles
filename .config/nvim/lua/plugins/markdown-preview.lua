return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }

      -- プレビューを閉じるタイミング
      vim.g.mkdp_auto_close = 0

      -- Markdown ファイルを開いたら自動でプレビューするか
      vim.g.mkdp_auto_start = 0

      -- プレビュー時にブラウザを自動で開く
      vim.g.mkdp_open_to_the_world = 0

      -- ローカルサーバーのアドレス
      vim.g.mkdp_preview_options = {
        sync_scroll_type = "middle",
      }
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Toggle Markdown Preview",
      },
      {
        "<leader>ms",
        "<cmd>MarkdownPreview<cr>",
        desc = "Start Markdown Preview",
      },
      {
        "<leader>mx",
        "<cmd>MarkdownPreviewStop<cr>",
        desc = "Stop Markdown Preview",
      },
    },
  },
}

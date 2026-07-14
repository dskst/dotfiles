return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function(plugin)
      -- ビルド時はまだ runtimepath に入っていないため autoload を解決できるようにする
      vim.opt.rtp:append(plugin.dir)
      vim.fn["mkdp#util#install_sync"]()
    end,
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

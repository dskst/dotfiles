local function has_file(bufnr, names)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(bufname)

  return #vim.fs.find(names, {
    path = dir,
    upward = true,
  }) > 0
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = function(bufnr)
        if has_file(bufnr, { "biome.json", "biome.jsonc" }) then
          return { "biome" }
        end
        return { "prettier" }
      end,

      typescript = function(bufnr)
        if has_file(bufnr, { "biome.json", "biome.jsonc" }) then
          return { "biome" }
        end
        return { "prettier" }
      end,

      python = function(bufnr)
        if has_file(bufnr, { "ruff.toml", ".ruff.toml" }) then
          return { "ruff_format" }
        end
        return { "black" }
      end,

      go = { "goimports", "gofmt" },

      java = { "google-java-format" },

      lua = { "stylua" },

      yaml = { "prettier" },
    },

    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
}

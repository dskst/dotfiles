return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      local linters_by_ft = {}

      if vim.fn.executable("eslint_d") == 1 then
        linters_by_ft.javascript = { "eslint_d" }
        linters_by_ft.typescript = { "eslint_d" }
        linters_by_ft.javascriptreact = { "eslint_d" }
        linters_by_ft.typescriptreact = { "eslint_d" }
      end

      if vim.fn.executable("markdownlint") == 1 then
        linters_by_ft.markdown = { "markdownlint" }
      end

      if vim.fn.executable("ansible-lint") == 1 then
        linters_by_ft["yaml.ansible"] = { "ansible_lint" }
      end

      lint.linters_by_ft = linters_by_ft

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}

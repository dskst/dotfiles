local jdtls = require("jdtls")

local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

local root_markers = {
  "gradlew",
  "mvnw",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  ".git",
}

local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == nil then
  return
end

local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"

local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local system = vim.loop.os_uname().sysname
local config_dir = "config_mac"

if system == "Darwin" then
  config_dir = "config_mac"
elseif system == "Linux" then
  config_dir = "config_linux"
elseif system == "Windows_NT" then
  config_dir = "config_win"
end

local bundles = {}

local config = {
  cmd = {
    "java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    "-jar", launcher,
    "-configuration", jdtls_path .. "/" .. config_dir,
    "-data", workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
  },

  init_options = {
    bundles = bundles,
  },

  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Java organize imports" }))
    vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Java extract variable" }))
    vim.keymap.set("v", "<leader>jv", [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]], vim.tbl_extend("force", opts, { desc = "Java extract variable" }))
    vim.keymap.set("v", "<leader>jm", [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], vim.tbl_extend("force", opts, { desc = "Java extract method" }))
    vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Java extract constant" }))
    vim.keymap.set("v", "<leader>jc", [[<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]], vim.tbl_extend("force", opts, { desc = "Java extract constant" }))
  end,
}

jdtls.start_or_attach(config)

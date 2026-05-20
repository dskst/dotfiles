local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

local home = os.getenv("HOME")

local root_markers = {
  "gradlew",
  "mvnw",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  ".git",
}

local root_dir = jdtls_setup.find_root(root_markers)

if root_dir == nil then
  return
end

local project_name = vim.fn.fnamemodify(root_dir:gsub("/$", ""), ":t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"

local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

if launcher == "" then
  vim.notify("jdtls: launcher jar not found", vim.log.levels.ERROR)
  return
end

local uname = vim.loop.os_uname()
local system = uname.sysname
local machine = uname.machine

local config_dir = "config_mac"

if system == "Darwin" then
  if machine == "arm64" or machine == "aarch64" then
    config_dir = "config_mac_arm"
  else
    config_dir = "config_mac"
  end
elseif system == "Linux" then
  if machine == "arm64" or machine == "aarch64" then
    config_dir = "config_linux_arm"
  else
    config_dir = "config_linux"
  end
elseif system == "Windows_NT" then
  config_dir = "config_win"
end

local resolved_config_dir = jdtls_path .. "/" .. config_dir

if vim.fn.isdirectory(resolved_config_dir) == 0 then
  vim.notify("jdtls: config dir not found: " .. resolved_config_dir, vim.log.levels.ERROR)
  return
end

local bundles = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local jdtls_java_version = os.getenv("NVIM_JDTLS_JAVA_VERSION")

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
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    launcher,
    "-configuration",
    resolved_config_dir,
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  capabilities = capabilities,

  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },

      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
      },

      signatureHelp = {
        enabled = true,
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
    extendedClientCapabilities = jdtls_setup.extendedClientCapabilities,
  },

  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set(
      "n",
      "<leader>jo",
      jdtls.organize_imports,
      vim.tbl_extend("force", opts, { desc = "Java organize imports" })
    )

    vim.keymap.set(
      "n",
      "<leader>jv",
      jdtls.extract_variable,
      vim.tbl_extend("force", opts, { desc = "Java extract variable" })
    )

    vim.keymap.set(
      "v",
      "<leader>jv",
      [[<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>]],
      vim.tbl_extend("force", opts, { desc = "Java extract variable" })
    )

    vim.keymap.set(
      "v",
      "<leader>jm",
      [[<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>]],
      vim.tbl_extend("force", opts, { desc = "Java extract method" })
    )

    vim.keymap.set(
      "n",
      "<leader>jc",
      jdtls.extract_constant,
      vim.tbl_extend("force", opts, { desc = "Java extract constant" })
    )

    vim.keymap.set(
      "v",
      "<leader>jc",
      [[<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>]],
      vim.tbl_extend("force", opts, { desc = "Java extract constant" })
    )
  end,
}

if jdtls_java_version ~= nil and jdtls_java_version ~= "" then
  config.cmd_env = {
    JENV_VERSION = jdtls_java_version,
  }
end

jdtls.start_or_attach(config)

vim.api.nvim_create_user_command("JdtR", "JdtWipeDataAndRestart", {})

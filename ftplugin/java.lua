local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local java_test = vim.fn.expand '$MASON/packages/java-test/extension/server/*.jar'
local java_debug = vim.fn.expand '$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.1.jar'

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local bundles = {
  vim.fn.glob(home .. java_debug, 1),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. java_test, 1), '\n'))

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_mac',
    '-data',
    workspace_dir,
  },

  root_dir = vim.fs.root(0, { 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
          'io.restassured.RestAssured.*',
        },
      },
      sources = {
        sourcePaths = {
          'src/main/java',
          'src/test/java',
          'build/generate-resources/main/src/main/java',
        },
      },
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = true,
      },
    },
  },

  init_options = {
    bundles = bundles,
  },
}

require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = '[O]rganize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract [V]ariable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract [V]ariable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract [C]onstant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract [C]onstant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract [M]ethod' })
vim.keymap.set('n', '<leader>ctm', "<Cmd>lua require('jdtls').test_nearest_method()<CR>", { desc = 'Test nearest [M]ethod' })
vim.keymap.set('n', '<leader>ctc', "<Cmd>lua require('jdtls').test_class()<CR>", { desc = 'Test [C]lass' })
vim.keymap.set('n', '<leader>ctp', "<Cmd>lua require('jdtls').pick_test(JdtTestOpts)<CR>", { desc = '[P]ick test method' })
vim.keymap.set('n', '<leader>cgt', "<Cmd>lua require('jdtls.tests').generate()<CR>", { desc = 'Generate [T]est' })

-- JdtShowLogs
-- JdtUpdateConfig - newly added config didn't load, try this otherwise restart lsp

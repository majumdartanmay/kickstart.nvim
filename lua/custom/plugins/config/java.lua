local function create_config() 
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t');
  local workspace_dir = './bin/data' .. project_name

  local config = {
    cmd = {

      '/home/tanmay/.sdkman/candidates/java/21.0.2-tem/bin/java', 
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', '/home/tanmay/Personal/jdtls_utility/bin/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', './bin/config_linux',
      '-data', workspace_dir
    },
  }
  return config, project_name
end



local function start_jdtls()
  local config, project_name = create_config();
  print("Attempting to start JDTLS at " .. project_name);
  require('jdtls').start_or_attach(config)
  print("Attempt to start JDLTS finished " .. project_name);
end

vim.keymap.set('n', '<C-1>', start_jdtls, { noremap = true, silent = true, desc = "Start JDTLS server" })


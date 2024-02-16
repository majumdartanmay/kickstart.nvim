local config = {
  cmd = {

    'C:/Program Files/Eclipse Adoptium/jdk-21.0.1.12-hotspot/bin/java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', 'C:/Users/TANMAY/AppData/Local/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', 'C:/Users/TANMAY/AppData/Local/jdtls//config_win',
  },
}

local function start_jdtls()
  print("Attempting to start JDTLS");
  require('jdtls').start_or_attach(config)
end

vim.keymap.set('n', '<M-j>', start_jdtls, { noremap = true, silent = true, desc = "Start JDTLS server" })


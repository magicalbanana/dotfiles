local home = os.getenv("HOME")
local jdtls = require("jdtls")
local utils = require("core.utils.functions")

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = utils.path_join(home, "/.local/share/eclipse/", vim.fn.fnamemodify(root_dir, ":p:h:t"))

-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Regular Neovim LSP client keymappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- Java extensions provided by jdtls
  nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  vim.keymap.set(
    "v",
    "<space>em",
    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" }
  )
end

local jdtls_path = utils.capture_cmd([[brew info jdtls | grep "/opt/homebrew/Cellar/" | awk '{print $1}']])

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
  root_dir = root_dir,   -- Set the root directory to our found root_marker
  -- Here you can configure eclipse.jdt.ls specific settings
  -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- cmd is the command that starts the language server. Whatever is placed
  -- here is what is passed to the command line to execute jdtls.
  -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- for the full list of options
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
    "-javaagent:" .. utils.path_join(home, "/.local/share/eclipse/lombok.jar"),
    -- The jar file is located where jdtls was installed. This will need to be updated
    -- to the location where you installed jdtls
    "-jar",
    utils.path_join(jdtls_path, "/libexec/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"),

    -- The configuration for jdtls is also placed where jdtls was installed. This will
    -- need to be updated depending on your environment
    "-configuration",
    utils.path_join(jdtls_path, "/libexec/config_mac"),

    -- Use the workspace_folder defined above to store data for this project
    "-data",
    workspace_folder,
  },
}

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)

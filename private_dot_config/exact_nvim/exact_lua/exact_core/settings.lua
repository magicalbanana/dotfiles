local M = {}

-- Toggle global status line
M.global_statusline = true
-- use rg instead of grep
M.grepprg = "rg --hidden --vimgrep --smart-case --"
-- set numbered lines
M.number = true
-- enable mouse see :h mouse
M.mouse = "nv"
-- set relative numbered lines
M.relative_number = true
-- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
M.showtabline = 1
-- enable or disable listchars
M.list = false
-- which list chars to schow
M.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"
-- Noice heavily changes the Neovim UI ...
M.enable_noice = true
-- Disable winbar with nvim-navic location
M.disable_winbar = false
-- Number of recent files shown in dashboard
-- 0 disables showing recent files
M.dashboard_recent_files = 5
-- disable the header of the dashboard
M.disable_dashboard_header = false
-- disable quick links of the dashboard
M.disable_dashboard_quick_links = false

M.treesitter_ensure_installed = {
  "arduino",
  "bash",
  "bibtex",
  "c",
  "clojure",
  "cmake",
  "comment",
  "commonlisp",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "elixir",
  "erlang",
  "fennel",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "git_config",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "graphql",
  "jq",
  "jsdoc",
  "json",
  "json5",
  "jsonc",
  "jsonnet",
  "kotlin",
  "latex",
  "lua",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "proto",
  "python",
  "regex",
  "ron",
  "rst",
  "ruby",
  "rust",
  "scss",
  "sql",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

-- LSPs that should be installed by Mason-lspconfig
M.lsp_servers = {
  "awk_ls",
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "elixirls",
  "erlangls",
  "eslint",
  "graphql",
  "jsonls",
  "jsonnet_ls",
  "kotlin_language_server",
  "ltex",
  "lua_ls",
  "marksman",
  "pyright",
  "rust_analyzer",
  "tailwindcss",
  "taplo",
  "terraformls",
  "texlab",
  "tsserver",
  "typst_lsp",
  "vimls",
  "yamlls",
}

-- Tools that should be installed by Mason
M.tools = {
  -- Formatter
  "black",
  "prettier",
  "stylua",
  "shfmt",
  -- Linter
  "eslint_d",
  "shellcheck",
  "tflint",
  "yamllint",
  "ruff",
  -- DAP
  "debugpy",
  "codelldb",
}

-- enable greping in hidden files
M.telescope_grep_hidden = true

-- which patterns to ignore in file switcher
M.telescope_file_ignore_patterns = {
  "%.7z",
  "%.JPEG",
  "%.JPG",
  "%.MOV",
  "%.RAF",
  "%.burp",
  "%.bz2",
  "%.cache",
  "%.class",
  "%.dll",
  "%.docx",
  "%.dylib",
  "%.epub",
  "%.exe",
  "%.flac",
  "%.ico",
  "%.ipynb",
  "%.jar",
  "%.jpeg",
  "%.jpg",
  "%.lock",
  "%.mkv",
  "%.mov",
  "%.mp4",
  "%.otf",
  "%.pdb",
  "%.pdf",
  "%.png",
  "%.rar",
  "%.sqlite3",
  "%.svg",
  "%.tar",
  "%.tar.gz",
  "%.ttf",
  "%.webp",
  "%.zip",
  "^.settings/",
  ".git/",
  ".gradle/",
  ".idea/",
  ".vale/",
  ".vscode/",
  "__pycache__/*",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "smalljre_*/*",
  "target/",
  "vendor/*",
}

return M

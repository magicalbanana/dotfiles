function CopyFilePathInfo(option, includeLineNumber)
  -- Get the current file name
  local filename = vim.fn.expand("%")

  -- Determine the option and retrieve the corresponding path information
  local pathInfo = ""
  if option == "relative" then
    -- Get the relative path of the current file with respect to the current working directory
    pathInfo = vim.fn.fnamemodify(filename, ":.")
  elseif option == "absolute" then
    -- Get the absolute path of the current file
    pathInfo = vim.fn.expand("%:p")
  elseif option == "directory" then
    -- Get the directory name of the current file
    pathInfo = vim.fn.expand("%:p:h")
  else
    print("Invalid option. Please choose 'relative', 'absolute', or 'directory'.")
    return
  end

  -- Include line number if requested for absolute or relative file paths
  if (option == "absolute" or option == "relative") and includeLineNumber then
    local lineNumber = vim.fn.line(".")
    pathInfo = pathInfo .. ":" .. lineNumber
  end

  -- Copy the information to the system clipboard
  vim.fn.setreg("+", pathInfo, "c")

  -- Provide feedback to the user
  local optionText = string.capitalize(option)
  vim.api.nvim_echo({ { "Copied " .. optionText .. " path:", "Title" }, { pathInfo, "String" } }, true, {})
end

vim.cmd([[command! -nargs=* CopyFilePathInfo lua CopyFilePathInfo(<f-args>)]])

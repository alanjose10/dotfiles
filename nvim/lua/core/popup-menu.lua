local M = {}

local function cmd_ok(cmd)
  pcall(vim.cmd, cmd)
end

local function has_lsp(buf)
  return next(vim.lsp.get_clients({ bufnr = buf })) ~= nil
end

local function has_diagnostics(buf)
  return #vim.diagnostic.get(buf) > 0
end

-- test url
-- http://www.google.com
local function has_url()
  local ok, urls = pcall(require("vim.ui")._get_urls)
  if ok and urls and #urls > 0 and vim.startswith(urls[1], "http") then
    return true
  end
  return false
end

local function in_git_repo()
  -- cheap check: look for .git in current file dir or cwd
  local cwd = vim.fn.getcwd()
  return vim.fn.isdirectory(cwd .. "/.git") == 1
end

local function plugin_loaded(name)
  return package.loaded[name] ~= nil
end

local function telescope_available()
  return pcall(require, "telescope.builtin")
end

local test_url = "http://www.google.com"
local function build_popup_menu()
  vim.cmd([[
    aunmenu PopUp

    amenu     PopUp.Open\ URL               gx

    anoremenu PopUp.Inspect                 <cmd>Inspect<CR>
    anoremenu PopUp.Inspect\ Tree           <cmd>InspectTree<CR>

    amenu     PopUp.-2-                     <NOP>

    " LSP
    anoremenu PopUp.Definition              <cmd>Telescope lsp_definitions<CR>
    anoremenu PopUp.Type\ Definition      <cmd>Telescope lsp_type_definitions<CR>
    anoremenu PopUp.References              <cmd>Telescope lsp_references<CR>
    anoremenu PopUp.Rename                  <cmd>lua vim.lsp.buf.rename()<CR>
    anoremenu PopUp.Code\ Action            <cmd>lua vim.lsp.buf.code_action()<CR>
    anoremenu PopUp.Hover                   <cmd>lua vim.lsp.buf.hover()<CR>

    amenu     PopUp.-3-                     <NOP>

    " Diagnostics
    anoremenu PopUp.Diagnostics\ (line)     <cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>
    anoremenu PopUp.Diagnostics\ (file)     <cmd>Telescope diagnostics<CR>

    amenu     PopUp.-4-                     <NOP>

    " Nav / Files
    nnoremenu PopUp.Back                    <C-o>
    nnoremenu PopUp.Forward                 <C-i>

    amenu     PopUp.-5-                     <NOP>

    " Git
    anoremenu PopUp.Git\ Blame\ Line        <cmd>Gitsigns blame_line<CR>
    anoremenu PopUp.Git\ Diff\ This         <cmd>Gitsigns diffthis<CR>
    
    amenu     PopUp.-6-                     <NOP>

    " Buffer
    anoremenu PopUp.Close\ Buffer           <cmd>bdelete<CR>
    anoremenu PopUp.Force\ Close            <cmd>bdelete!<CR>

 ]])
end

local function disable_all()
  cmd_ok("amenu disable PopUp.Definition")
  cmd_ok("amenu disable PopUp.Type\\ Definition")
  cmd_ok("amenu disable PopUp.References")
  cmd_ok("amenu disable PopUp.Rename")
  cmd_ok("amenu disable PopUp.Code\\ Action")
  cmd_ok("amenu disable PopUp.Hover")

  cmd_ok("amenu disable PopUp.Diagnostics\\ \\(line\\)")
  cmd_ok("amenu disable PopUp.Diagnostics\\ \\(file\\)")

  cmd_ok("amenu disable PopUp.Git\\ Blame\\ Line")
  cmd_ok("amenu disable PopUp.Git\\ Diff\\ This")

  cmd_ok("amenu disable PopUp.Open\\ URL")
end

local function enable_context(buf)
  local lsp = has_lsp(buf)
  local diag = has_diagnostics(buf)
  local url = has_url()
  local git = in_git_repo()
  local has_telescope = telescope_available()

  -- LSP
  if lsp then
    if has_telescope then
      cmd_ok("amenu enable PopUp.Definition")
      cmd_ok("amenu enable PopUp.Type\\ Definition")
      cmd_ok("amenu enable PopUp.References")
    end
    cmd_ok("amenu enable PopUp.Rename")
    cmd_ok("amenu enable PopUp.Code\\ Action")
    cmd_ok("amenu enable PopUp.Hover")
  end

  -- Diagnostics
  if diag then
    cmd_ok("amenu enable PopUp.Diagnostics\\ \\(line\\)")
    if has_telescope then
      cmd_ok("amenu enable PopUp.Diagnostics\\ \\(file\\)")
    end
  end

  -- Git (only if plugin + repo)
  if git and plugin_loaded("gitsigns") then
    cmd_ok("amenu enable PopUp.Git\\ Blame\\ Line")
    cmd_ok("amenu enable PopUp.Git\\ Diff\\ This")
  end

  -- URL
  if url then
    cmd_ok("amenu enable PopUp.Open\\ URL")
  end
end

function M.setup()
  build_popup_menu()

  local group = vim.api.nvim_create_augroup("nvim.popupmenu", { clear = true })

  vim.api.nvim_create_autocmd("MenuPopup", {
    group = group,
    pattern = "*",
    desc = "Context-aware PopUp menu",
    callback = function(ev)
      local buf = ev.buf or 0
      disable_all()
      enable_context(buf)
    end,
  })
end

return M

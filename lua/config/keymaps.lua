-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- Map \ to toggle file explorer (LazyVim's default file explorer)
keymap("n", "\\", function()
  require("snacks").explorer()
end, { desc = "Toggle file explorer" })

-- Clear search highlight
keymap("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", { silent = true })

-- Format entire file
keymap("n", "<leader>=", "gg=G``", { desc = "Format entire file" })

-- Yank entire file
keymap("n", "<leader>y", "ggyG``", { desc = "Yank entire file" })

-- Escape insert mode with jk
keymap("i", "jk", "<esc>", { desc = "Escape insert mode" })

-- Copy to system clipboard
keymap("v", "<C-c>", '"*y', { desc = "Copy to system clipboard" })

-- Escape terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })

-- Copy file paths
keymap("n", "<leader>cf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", filepath)
  print("Copied full path to clipboard: " .. filepath)
end, { desc = "Copy full file path to clipboard" })

keymap("n", "<leader>cd", function()
  local dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  vim.fn.setreg("+", dirname)
  print("Copied directory path to clipboard: " .. dirname)
end, { desc = "Copy directory path to clipboard" })

-- Vimux commands
keymap("n", "<leader>t", function()
  vim.fn.VimuxOpenRunner()
end, { silent = true, desc = "Open Vimux runner" })

keymap("n", "<leader>T", function()
  vim.fn.VimuxCloseRunner()
end, { silent = true, desc = "Close Vimux runner" })

-- Number modes
keymap({ "n", "v" }, "<leader>5", ":set number relativenumber<CR>", { desc = "Set relative numbers" })
keymap({ "n", "v" }, "<leader>6", ":set number norelativenumber<CR>", { desc = "Set absolute numbers" })
keymap({ "n", "v" }, "<leader>7", ":RN<CR>", { desc = "Set both absolute and relative numbers" })

-- Cycle through capital marks
keymap("n", "<leader>mm", function()
  local marks = vim.fn.getmarklist()
  local capitals = {}

  for _, mark in ipairs(marks) do
    local m = mark.mark
    local pos = mark.pos or {}

    if m and m:match("^'[A-Z]$") and #pos >= 3 then
      local file = mark.file
      local bufnr = file and vim.fn.bufnr(file) or -1

      if bufnr == -1 and file then
        vim.cmd("edit " .. vim.fn.fnameescape(file))
        bufnr = vim.fn.bufnr(file)
      end

      if bufnr ~= -1 then
        table.insert(capitals, { mark = m, bufnr = bufnr, line = pos[2], col = pos[3] })
      end
    end
  end

  if #capitals == 0 then
    print("No valid capital marks found")
    return
  end

  table.sort(capitals, function(a, b)
    return a.bufnr == b.bufnr and a.line < b.line or a.bufnr < b.bufnr
  end)

  local cur_buf = vim.api.nvim_get_current_buf()
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]

  for _, mark in ipairs(capitals) do
    if mark.bufnr > cur_buf or (mark.bufnr == cur_buf and mark.line > cur_line) then
      vim.api.nvim_set_current_buf(mark.bufnr)
      vim.api.nvim_win_set_cursor(0, { mark.line, mark.col })
      return
    end
  end

  local first_mark = capitals[1]
  vim.api.nvim_set_current_buf(first_mark.bufnr)
  vim.api.nvim_win_set_cursor(0, { first_mark.line, first_mark.col })
end, { desc = "Cycle through capital marks across buffers" })

vim.api.nvim_create_user_command("Google", function(o)
  local escaped = vim.uri_encode(o.args)
  local url = ("https://www.google.com/search?q=%s"):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = "just google it" })

vim.api.nvim_create_user_command("DuckDuckGo", function(o)
  local escaped = vim.uri_encode(o.args)
  local url = ("https://duckduckgo.com/?q=%s"):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = "just google i mean duckduckgo it" })

-- close all buffers except the current one
vim.api.nvim_create_user_command("Bufo", "%bd|e#|bd#", {})

-- close every buffer
vim.api.nvim_create_user_command("Bufc", "%bd", {})

vim.api.nvim_create_user_command("Delmark", "delmark A-Za-z", {})

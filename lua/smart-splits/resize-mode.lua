local M = {}

function M.start_resize_mode()
  if vim.fn.mode() ~= 'n' then
    vim.notify('Resize mode must be triggered from normal mode', vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_set_keymap('n', 'h', ":lua require('smart-splits').resize_left()<CR>", { silent = true })
  vim.api.nvim_set_keymap('n', 'l', ":lua require('smart-splits').resize_right()<CR>", { silent = true })
  vim.api.nvim_set_keymap('n', 'j', ":lua require('smart-splits').resize_down()<CR>", { silent = true })
  vim.api.nvim_set_keymap('n', 'k', ":lua require('smart-splits').resize_up()<CR>", { silent = true })
  vim.api.nvim_set_keymap(
    'n',
    '<ESC>',
    ":lua require('smart-splits.resize-mode').end_resize_mode()<CR>",
    { silent = true }
  )

  local msg = 'Persistent resize mode enabled. Use h/j/k/l to resize, and <ESC> to finish.'
  print(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

function M.end_resize_mode()
  vim.api.nvim_del_keymap('n', 'h')
  vim.api.nvim_del_keymap('n', 'l')
  vim.api.nvim_del_keymap('n', 'j')
  vim.api.nvim_del_keymap('n', 'k')
  vim.api.nvim_del_keymap('n', '<ESC>')

  local msg = 'Persistent resize mode disabled. Normal keymaps have been restored.'
  print(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

return M

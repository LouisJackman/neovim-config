local cmd = vim.cmd
local opt = vim.opt

return function()
  vim.g.mapleader = ' '

  local set = vim.keymap.set

  set('n', '<leader>ev', function() cmd 'edit $MYVIMRC' end, {silent = true})
  set('n', '<leader>sv', function() cmd 'source $MYVIMRC' end, {silent = true})

  set('i', 'fd', '<esc>')
  set('v', 'fd', '<esc>')

  set('n', '<leader>w', function() cmd 'write' end, {silent = true})
  set('n', '<leader>q', function() cmd 'quit' end, {silent = true})

  set('n', '<leader>d', function() cmd 'bdelete' end, {silent = true})
  set('n', '<leader>c', '<c-w>c')

  set('n', '<leader>h', '<c-w>h')
  set('n', '<leader>j', '<c-w>j')
  set('n', '<leader>k', '<c-w>k')
  set('n', '<leader>l', '<c-w>l')
  set('n', '<leader>v', '<c-w>v')
  set('n', '<leader>s', '<c-w>s')
  set('n', '<leader>c', '<c-w>c')
  set('n', '<leader>o', '<c-w>o')

  set('n', '<leader><', '<c-w><')
  set('n', '<leader>>', '<c-w>>')
  set('n', '<leader>+', '<c-w>+')
  set('n', '<leader>-', '<c-w>-')
  set('n', '<leader>=', '<c-w>=')

  set('n', '<leader>sp', function() opt.paste = true end, {silent = true})
  set('n', '<leader>np', function() opt.paste = false end, {silent = true})

  set('n', '<leader>hl', function() opt.hlsearch = true end, {silent = true})
  set('n', '<leader>nh', function() opt.hlsearch = false end, {silent = true})

  set('n', '<leader>lo', function() cmd 'lopen' end, {silent = true})
  set('n', '<leader>lc', function() cmd 'lclose' end, {silent = true})
  set('n', '<leader>ln', function() cmd 'lnext' end, {silent = true})
  set('n', '<leader>lp', function() cmd 'lprevious' end, {silent = true})
  set('n', '<leader>lf', function() cmd 'lfirst' end, {silent = true})
  set('n', '<leader>lla', function() cmd 'llast' end, {silent = true})
  set('n', '<leader>lli', function() cmd 'llist' end, {silent = true})

  set('n', '<leader>co', function() cmd 'copen' end, {silent = true})
  set('n', '<leader>cc', function() cmd 'cclose' end, {silent = true})
  set('n', '<leader>cn', function() cmd 'cnext' end, {silent = true})
  set('n', '<leader>cp', function() cmd 'cprevious' end, {silent = true})
  set('n', '<leader>cf', function() cmd 'cfirst' end, {silent = true})
  set('n', '<leader>cla', function() cmd 'clast' end, {silent = true})
  set('n', '<leader>cli', function() cmd 'clist' end, {silent = true})

  set('n', '<leader>tn', function() cmd 'tabnew' end, {silent = true})

  set('n', 'n', 'nzz')
  set('n', 'N', 'Nzz')
  set('n', '*', '*zz')
  set('n', '#', '#zz')
  set('n', 'g*', 'g*zz')
  set('n', 'g#', 'g#zz')
end


local cmd = vim.cmd
local opt = vim.opt

return function()
  vim.g.mapleader = ' '

  local set = vim.keymap.set

  set('n', '<leader>ev', function() cmd.edit(vim.env.MYVIMRC) end, {silent = true})
  set('n', '<leader>sv', function() cmd.source(vim.env.MYVIMRC) end, {silent = true})

  set('i', 'fd', '<esc>')
  set('v', 'fd', '<esc>')

  set('n', '<leader>w', cmd.write, {silent = true})
  set('n', '<leader>q', cmd.quit, {silent = true})

  set('n', '<leader>d', cmd.bdelete, {silent = true})
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

  set('n', '<leader>lo', cmd.lopen, {silent = true})
  set('n', '<leader>lc', cmd.lclose, {silent = true})
  set('n', '<leader>ln', cmd.lnext, {silent = true})
  set('n', '<leader>lp', cmd.lprevious, {silent = true})
  set('n', '<leader>lf', cmd.lfirst, {silent = true})
  set('n', '<leader>lla', cmd.llast, {silent = true})
  set('n', '<leader>lli', cmd.llist, {silent = true})

  set('n', '<leader>co', cmd.copen, {silent = true})
  set('n', '<leader>cc', cmd.cclose, {silent = true})
  set('n', '<leader>cn', cmd.cnext, {silent = true})
  set('n', '<leader>cp', cmd.cprevious, {silent = true})
  set('n', '<leader>cf', cmd.cfirst, {silent = true})
  set('n', '<leader>cla', cmd.clast, {silent = true})
  set('n', '<leader>cli', cmd.clist, {silent = true})

  set('n', '<leader>tn', cmd.tabnew, {silent = true})

  set('n', 'n', 'nzz')
  set('n', 'N', 'Nzz')
  set('n', '*', '*zz')
  set('n', '#', '#zz')
  set('n', 'g*', 'g*zz')
  set('n', 'g#', 'g#zz')
end


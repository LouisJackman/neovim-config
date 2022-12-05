local opt = vim.opt

return function()
  opt.backup = false

  -- With this line, the command line only appears when used. While elegant it
  -- means any output must be 'acknowledged', otherwise stdin gets hijacked
  -- until enter is pressed. Too many packages output messages excessively,
  -- making it annoying in practice. Until the Neovim package ecosystem
  -- addresses that, leave this line disabled.
  --
  -- opt.cmdheight = 0

  opt.completeopt = {'menuone', 'noselect'}
  opt.cursorline = true
  opt.expandtab = true
  opt.laststatus = 3
  opt.number = true
  opt.path:append '**'
  opt.scrolloff = 5
  opt.shiftwidth = 4
  opt.smartcase = true
  opt.smartindent = true
  opt.softtabstop = 4
  opt.swapfile = false
  opt.tabstop = 4
  opt.textwidth = 80
  opt.wildmenu = true
  opt.wildmode = {'longest:full', 'full'}
  opt.wrap = false
  opt.writebackup = false
end


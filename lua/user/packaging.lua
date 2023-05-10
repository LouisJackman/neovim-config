local api = vim.api
local fn = vim.fn

local function set_up_cmp_enhanced_lsp(provider, cmd)
  require 'lspconfig'[provider].setup {
    capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = cmd,

    on_attach = function(_, buffer_number)
      vim.api.nvim_buf_set_option(buffer_number, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end,
  }
end

local function bootstrap_lazy(lazy_version)
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  local did_bootstrap
  if vim.loop.fs_stat(lazypath) then
    did_bootstrap = false
  else
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=" .. lazy_version,
      lazypath,
    }
    did_bootstrap = true
  end
  vim.opt.rtp:prepend(lazypath)
  return did_bootstrap
end

local function set_up(opts)
  local lazy_version = opts.lazy_version

  local did_bootstrap_lazy = bootstrap_lazy(lazy_version)

  require 'lazy'.setup('user.packages', {
    git = { timeout = 60 * 5 }
  })

  if did_bootstrap_lazy then
    print('As lazy.nvim was bootstrapped, running `:Lazy! install`...')
    vim.cmd 'Lazy! install'
    print('Finished `lazy.sync()`.')

    print('As lazy.nvim was bootstrapped, running `TSUpdateSync` from nvim-treesitter...')
    vim.cmd.TSUpdateSync()
    print('Finished `TSUpdateSync`')
  end
end

return {
  set_up                  = set_up,
  set_up_cmp_enhanced_lsp = set_up_cmp_enhanced_lsp,
}


-- Reliably bootstrapping a deterministically-pinned packer.nvim into an
-- immutable image is surprisingly tricky. The current approach is a
-- cargo-culted combination of these:
--
-- - https://gitlab.com/louis.jackman/dockerfiles/-/blob/0beee055d9fe8afcc298a9e5c272e265a3f56ed4/contexts/03-base-dev/scripts/configure_nvim.rb#L30
-- - https://github.com/wbthomason/packer.nvim#bootstrapping
-- - https://github.com/onichandame/docker-dev/blob/795a02d449cf2ef535e73ec991f078db25dbe88e/files/nvim/lua/plugins/init.lua#L48
-- - https://github.com/wbthomason/packer.nvim/issues/502#issuecomment-1135331998


local package_versions = require 'user.package_versions'

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

local function make_packages(args)
  local versions = args.versioned_against
  local packages = args[1]

  local replacement = {}
  for key, value in pairs(packages) do

    local version, package
    if type(key) == 'number' then
      version = versions[value]
      package = {value}
    else
      version = versions[key]
      package = vim.deepcopy(value)
      package[1] = key
    end

    local version_type = version[1]
    local version_value = version[2]

    package[version_type] = version_value

    if package.requires ~= nil then
      package.requires = make_packages {
        versioned_against = versions,
        package.requires,
      }
    end

    table.insert(replacement, package)
  end

  return replacement
end

local function bootstrap_packer(packer_commit)
  local packer_did_bootstrap = false

  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if 0 < fn.empty(fn.glob(install_path)) then
    print('packer.nvim package missing; starting bootstrap...')
    packer_did_bootstrap = fn.system {
      'git', 'clone',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    }
    if not packer_did_bootstrap then
      error("package.nvim was missing, but did not successfully bootstrap due to failed git clone of packer.nvim's repository")
    end

    packer_did_bootstrap = fn.system {
      'git', 'reset', '--hard', packer_commit,
    }
    if not packer_did_bootstrap then
      error("package.nvim was missing, but did not successfully bootstrap due to failed git reset of packer.nvim's repository to pinned commit")
    end

    vim.cmd.packadd 'packer.nvim'
    print('package.nvim bootstrap completed.')
  end

  return packer_did_bootstrap
end

function packer_blocking_sync()
  local packer = require 'packer'

  local completed = false

  api.nvim_create_autocmd('User', {
    pattern = 'PackerComplete',

    callback = function()
      completed = true
    end,
  })

  packer.sync()

  -- Why not use a coroutine and yield on the event callback? Doing so involves
  -- passing through C code, which Lua coroutines can't handle within Neovim.
  -- Therefore, this unfortunate spinlock is necessary. The sleep is used to
  -- avoid burning through the CPU too much while the operation completes.
  repeat
    vim.cmd.sleep(1)
  until completed
end

local function set_up(packages)
  local packer_version = package_versions['wbthomason/packer.nvim']
  local packer_version_type = packer_version[1]
  local packer_version_value = packer_version[2]

  local did_bootstrap_packer = bootstrap_packer(packer_version_value)

  local packer = require 'packer'

  packer.init {
    git = { clone_timeout = 60 * 5 }
  }

  packer.use {
    'wbthomason/packer.nvim',
    [packer_version_type] = packer_version_value,
  }

  local normalised_packages = make_packages {
    versioned_against = package_versions,
    packages,
  }
  packer.use(normalised_packages)

  if did_bootstrap_packer then
    print('As packer.nvim was bootstrapped, running `packer.sync()`...')
    packer_blocking_sync()
    print('Finished `packer.sync()`.')

    print('As packer.nvim was bootstrapped, running `TSUpdateSync` from nvim-treesitter...')
    vim.cmd.TSUpdateSync()
    print('Finished `TSUpdateSync`')
  end
end

return {
  set_up                  = set_up,
  set_up_cmp_enhanced_lsp = set_up_cmp_enhanced_lsp,
}


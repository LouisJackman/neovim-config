local package_versions = require 'user.package_versions'

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

local function set_up(third_party_packages, opts)

  vim.cmd.packadd 'packer.nvim'

  local packer = require 'packer'

  packer.init {
    git = { clone_timeout = 60 * 5 }
  }

  local packer_version = package_versions['wbthomason/packer.nvim']
  local packer_version_type = packer_version[1]
  local packer_version_value = packer_version[2]
  packer.use {
    'wbthomason/packer.nvim',
    [packer_version_type] = packer_version_value,
  }

  if opts.use_third_party_packages then
    local normalised_packages = make_packages {
      versioned_against = package_versions,
      third_party_packages,
    }
    packer.use(normalised_packages)
  end
end

return {
  set_up                  = set_up,
  set_up_cmp_enhanced_lsp = set_up_cmp_enhanced_lsp,
}


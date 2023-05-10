local opt = vim.opt

local function nop() end

local additional_setup_path = vim.fn.stdpath('config') .. '/lua/user/additional_setup.lua'

local function lookup_derived_environment()
  -- Let derived environments extend this configuration by declaring their own
  -- two optional hooks: one runs before standard initialisation, the other runs
  -- afterwards. They are `pre_init` and `post_init` functions respectively, and
  -- must be defined in a Lua module exported from
  -- `~/.config/nvim/lua/user/additional_setup.lua`.

  local additional_setup_exists
  if vim.loop.fs_stat(additional_setup_path) then
    additional_setup_exists = true
  else
    additional_setup_exists = false
  end

  local additional_setup
  if additional_setup_exists then
    additional_setup = require 'user.additional_setup'
    if type(additional_setup) ~= 'table' then
      error('the additional setup module at `' .. additional_setup_path .. '` must return a table of two optional functions: `pre_init` and `post_init`')
    end
  else
    additional_setup = {}
  end

  local use_third_party_packages
  -- Coerce a truthy value into true, and default a completely missing value to
  -- true. Anything else becomes a false.
  if (additional_setup.use_third_party_packages == nil) or additional_setup.use_third_party_packages then
    use_third_party_packages = true
  else
    use_third_party_packages = false
  end

  local pre_init
  if additional_setup.pre_init == nil then
    pre_init = nop
  else
    local f = additional_setup.pre_init
    pre_init = function() f() end
  end

  local post_init
  if additional_setup.post_init == nil then
    post_init = nop
  else
    local f = additional_setup.post_init
    post_init = function() f() end
  end

  return {
    use_third_party_packages = use_third_party_packages,
    pre_init                 = pre_init,
    post_init                = post_init,
  }
end

return {
  nop                        = nop,
  lookup_derived_environment = lookup_derived_environment,
}


-- Due to FENV manipulation by some third party packages, some variable lookups
-- in this user configuration must use a global rather than lexical scoping. For
-- such cases, always use this top-level `user` table.
user = {}

local utils                        = require 'user.utils'
local set_options                  = require 'user.set_options'
local bind_keys                    = require 'user.bind_keys'
local set_up_base_language_support = require 'user.set_up_base_language_support'
local packages                     = require 'user.packages'
local packaging                    = require 'user.packaging'

local function init()
  local env = utils.lookup_derived_environment()

  user.set_up_cmp_enhanced_lsp = packaging.set_up_cmp_enhanced_lsp

  env.pre_init()

  set_options()
  utils.lock_down_mode_line()
  bind_keys()
  set_up_base_language_support()

  -- Some derived environments may not want to run so much third party code for
  -- either security or performance reasons. Skip third party packages entirely
  -- in such a case.
  packaging.set_up(
    packages,
    {use_third_party_packages = env.use_third_party_packages}
  )

  env.post_init()
end

init()


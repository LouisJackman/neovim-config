-- Due to FENV manipulation by some third party packages, some variable lookups
-- in this user configuration must use a global rather than lexical scoping. For
-- such cases, always use this top-level `user` table.
_G.user = {}

local utils                        = require 'user.utils'
local set_options                  = require 'user.set_options'
local bind_keys                    = require 'user.bind_keys'
local set_up_base_language_support = require 'user.set_up_base_language_support'

local lazy_version = 'v9.14.11'

local function init()
  local env = utils.lookup_derived_environment()

  env.pre_init()

  set_options()
  bind_keys()
  set_up_base_language_support()

  -- Some derived environments may not want to run so much third party code for
  -- either security or performance reasons. Skip third party packages entirely
  -- in such a case.
  if env.use_third_party_packages then
    local packaging = require 'user.packaging'

    user.set_up_cmp_enhanced_lsp = packaging.set_up_cmp_enhanced_lsp
    packaging.set_up { lazy_version = lazy_version }
  end

  env.post_init()
end

init()


local opt = vim.opt

local function nop() end

local function lookup_derived_environment()
  -- Let derived environments extend this configuration by declaring their own
  -- two optional hooks: one runs before standard initialisation, the other runs
  -- afterwards. They are `pre_init` and `post_init` functions respectively, and
  -- must be defined in a Lua module exported from
  -- `~/.config/nvim/lua/user/additional_setup.lua`.
  local ok, additional_setup = pcall(require, 'user.additional_setup')

  local use_third_party_packages
  -- Coerce a truthy value into true, and default a completely missing value to
  -- true. Anything else becomes a false.
  if (additional_setup.use_third_party_packages == nil) or additional_setup.use_third_party_packages then
    use_third_party_packages = true
  else
    use_third_party_packages = false
  end

  local pre_init, post_init
  if ok then

    if type(additional_setup) ~= 'table' then
      error('the additional setup module at `~/.config/nvim/lua/user/additional_setup.lua` must return a table of two optional functions: `pre_init` and `set_up`')
    end

    if additional_setup.pre_init == nil then
      pre_init = nop
    else
      local f = additional_setup.pre_init
      pre_init = function() f() end
    end

    if additional_setup.post_init == nil then
      post_init = nop
    else
      local f = additional_setup.post_init
      post_init = function() f() end
    end

  else
    pre_init = nop
    post_init = nop
  end

  return {
    use_third_party_packages = use_third_party_packages,
    pre_init = pre_init,
    post_init = post_init,
  }
end

return {
  nop                                 = nop,
  lookup_derived_environment          = lookup_derived_environment,
}


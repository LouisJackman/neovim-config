local opt = vim.opt

local function nop() end

local fail_on_missing_lookups
do
  local meta = {
    __index = function(table, i)
      local msg = string.format(
        "undefined index %s on %s",
        vim.inspect(i),
        vim.inspect(table)
      )
      error(msg)
    end,
  }

  fail_on_missing_lookups = function(table)
    setmetatable(table, meta)
    return table
  end
end

local function lock_down_mode_line()
  -- Addresses CVE-2019-12735
  -- See https://nvd.nist.gov/vuln/detail/CVE-2019-12735

  opt.modeline = false
  opt.modelines = 0
end

local function set_up_lua_based_filetype_detection()
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0
end

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
  fail_on_missing_lookups             = fail_on_missing_lookups,
  lock_down_mode_line                 = lock_down_mode_line,
  set_up_lua_based_filetype_detection = set_up_lua_based_filetype_detection,
  lookup_derived_environment          = lookup_derived_environment,
}


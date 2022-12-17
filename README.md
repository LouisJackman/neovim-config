# neovim-config

My [Neovim](https://neovim.io/) configuration, as used by [my
dockerfiles](https://gitlab.com/louis.jackman/dockerfiles) and elsewhere.
Entirely [Lua](https://www.lua.org/about.html)-based and running on [Neovim
0.8](https://github.com/neovim/neovim/releases/tag/v0.8.0). Reproducible [with
pinned third-party package versions](./lua/user/package_versions.lua), and
focused on [LSP (the Language Server
Protocol)](https://en.wikipedia.org/wiki/Language_Server_Protocol).

- Pure Lua configuration, no VimScript.
- Expects LSP-based tooling by default and accomodates it.
- Declarative package definitions [with exact pinned
  versions](./lua/user/package_versions.lua) for reproducibility.
- [Spacemacs](https://www.spacemacs.org/)/[Doom
  Emacs](https://github.com/doomemacs/doomemacs)-inspired keybindings which
  embrace Vim's keybindings but additionally utilise space as the leader key.
  The additional keybindings are still in the spirit of Vim, but more egonomic
  due to tapping space rather than holding modifier keys on the side of the
  keyboard.
- **Try it out without installing anything on your main system, even if you
  don't have Neovim.** Use an image from my dockerfiles that combine this config
  with a preinstalled version of Neovim 0.8:
  `docker run -it --rm -v "$PWD:/home/user/workspace" registry.gitlab.com/louis.jackman/dockerfiles/base-dev:0.0.21`.
  Once inside that container's shell, run `vi` or `nvim`.
- The ability to add `additional_setup.lua` files in derived environments for
  additional custom configuration -- used in [my
  dockerfiles](https://gitlab.com/louis.jackman/dockerfiles) for
  environment-specific additions such as installing language-specific packages
  and LSP configurations.
- Lua-based packages used for third party packages whenever possible; currently
  only the Nord colour scheme is still VimScript-based, as far as I know.
- A single flag for disabling all downloaded packages while retaining the
  configuration's core benefits. Run it fully-fledged within chroot jails, but
  run a more minimal version on your main system to reduce the impact of
  potential [supply chain
  attacks](https://en.wikipedia.org/wiki/Supply_chain_attack) against Neovim
  package authors.

## Official Mirror of the GitLab Repository

This repository is currently hosted [on
GitLab.com](https://gitlab.com/louis.jackman/neovim-config). Official mirrors
exist on [SourceHut](https://git.sr.ht/~louisjackman/neovim-config) and
[GitHub](https://github.com/LouisJackman/neovim-config). At the moment, GitLab
is still the official hub for contributions such as PRs and issues.

## Installing

Clone the repository to `~/.config/nvim`, assuming that directory doesn't yet
exist:

```sh
git clone https://gitlab.com/louis.jackman/neovim-config.git ~/.config/nvim
```

Alternatively, clone it elsewhere or download the source tarball and unpack it,
and then symlink the directory to `~/.config/neovim`. Or use something like [GNU
Stow](https://www.gnu.org/software/stow/).

## Configuring

To add your own configuration, the best way is to add a new file called
`additional_setup.lua` within `lua/user`. It expects a table to be returned from
the file with three _optional_ keys defined:

- `use_third_party_packages`: a boolean value that determines whether to pull in
  third party packages, i.e. anything outside of core Neovim.
- `pre_init`: a function called before the configuration's main setup.
- `post_init`: a function called after the configuration's main setup.

For example, this configuration
disables third party packages which is a good idea when running outside of a
chroot jail or a container:

```lua
return {
  use_third_party_packages = false,
}
```

For a configuration running inside an isolated environment that wants more
features, it can keep third party packages enabled and start adding more
nicities such as LSP configuration. Here's an example for JavaScript
development that adds auto-completion and language support:

```lua
local additional_setup = {}

function additional_setup.post_init()
  require 'packer'.use {
    {'pangloss/vim-javascript',    commit = 'c470ce1399a544fe587eab950f571c83cccfbbdc'},
    {'MaxMEllon/vim-jsx-pretty',   commit = '6989f1663cc03d7da72b5ef1c03f87e6ddb70b41'},
    {'leafgarland/typescript-vim', commit = '52f3ca3474d51f5021696ffb7297d989e49121ac'},
    {'ianks/vim-tsx',              commit = '77c89c42e189fefd3c9a632b37b7e3b3b9edf918'},
  }

  vim.api.nvim_create_autocmd('filetype', {
    pattern = 'javascript.jsx,typescript.tsx,javascript',

    callback = function()
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
    end,
  })

  user.set_up_cmp_enhanced_lsp('tsserver', {'typescript-language-server', '--stdio'})
  user.set_up_cmp_enhanced_lsp('stylelint_lsp', {'stylelint-lsp', '--stdio'})
end

return additional_setup
```


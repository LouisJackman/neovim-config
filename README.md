# neovim-config

My [Neovim](https://neovim.io/) configuration, as used by [my
dockerfiles](https://gitlab.com/louis.jackman/dockerfiles) and elsewhere.
Entirely [Lua-based](https://www.lua.org/about.html) and running on [Neovim
0.8](https://github.com/neovim/neovim/releases/tag/v0.8.0). Reproducible with
pinned third-party package versions, and focussed on [LSP (the Language Server
Protocol)](https://en.wikipedia.org/wiki/Language_Server_Protocol).

- Pure Lua configuration, no VimScript.
- Expects LSP-based tooling by default and accomodates it.
- Uses modern Neovim 0.8 features such as Lua-based autogroups and
  `vim.cmd.CMD`.
- Declarative package definitions [with _exact_ pinned
  versions](./user/package_versions.lua) for reproducibility.
- [Spacemacs](https://www.spacemacs.org/)/[Doom
  Emacs](https://github.com/doomemacs/doomemacs)-inspired keybindings which
  embrace Vim's keybindings but additionally utilise space as the leader key.
  The additional keybindings are still in the spirit of Vim, but more egonomic
  due to tapping space rather than holding modifier keys on the side of the
  keyboard.
- The ability to add `additional_setup.lua` files in derived environments for
  additional custom configuration -- used in [my
  dockerfiles](https://gitlab.com/louis.jackman/dockerfiles) for
  environment-specific additions such as installing language-specific packages
  and LSP configurations.
- Lua-based packages used for third party packages whenever possible; currently
  only the Nord colour scheme is still VimScript-based, as far as I know.
- Try it out without installing anything on your main system. Use an image from
  my dockerfiles that combine this config with a preinstalled version of Neovim
  0.8: `docker run -it --rm -v "$PWD:/home/user/workspace"
  registry.gitlab.com/louis.jackman/dockerfiles/base-dev:0.0.7`.

## Official Mirror of the GitLab Repository

This repository is currently hosted [on
GitLab.com](https://gitlab.com/louis.jackman/dockerfiles). Official mirrors
exist on [SourceHut](https://git.sr.ht/~louisjackman/dockerfiles) and
[GitHub](https://github.com/LouisJackman/dockerfiles). At the moment, GitLab
is still the official hub for contributions such as PRs and issues.


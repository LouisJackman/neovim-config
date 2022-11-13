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
- Declarative package definitions [with _exact_ pinned
  versions](./lua/user/package_versions.lua) for reproducibility.
- [Spacemacs](https://www.spacemacs.org/)/[Doom
  Emacs](https://github.com/doomemacs/doomemacs)-inspired keybindings which
  embrace Vim's keybindings but additionally utilise space as the leader key.
  The additional keybindings are still in the spirit of Vim, but more egonomic
  due to tapping space rather than holding modifier keys on the side of the
  keyboard.
- Uses modern Neovim 0.8 features such as Lua-based autogroups and
  `vim.cmd.CMD`.
- The ability to add `additional_setup.lua` files in derived environments for
  additional custom configuration -- used in [my
  dockerfiles](https://gitlab.com/louis.jackman/dockerfiles) for
  environment-specific additions such as installing language-specific packages
  and LSP configurations.
- **Try it out without installing anything on your main system.** Use an image
  from my dockerfiles that combine this config with a preinstalled version of
  Neovim 0.8:
  `docker run -it --rm -v "$PWD:/home/user/workspace" registry.gitlab.com/louis.jackman/dockerfiles/base-dev:0.0.7`.
  Once inside that container's shell, run `vi` or `nvim`.
- Lua-based packages used for third party packages whenever possible; currently
  only the Nord colour scheme is still VimScript-based, as far as I know.
- A single flag for disabling all third-party packages while retaining the
  configuration's core benefits. Run full-fledged within chroot jails but run a
  more minimal version on your main system to reduce the risk of [supply chain
  attacks](https://en.wikipedia.org/wiki/Supply_chain_attack) against Neovim
  package authors.

## Official Mirror of the GitLab Repository

This repository is currently hosted [on
GitLab.com](https://gitlab.com/louis.jackman/neovim-config). Official mirrors
exist on [SourceHut](https://git.sr.ht/~louisjackman/neovim-config) and
[GitHub](https://github.com/LouisJackman/neovim-config). At the moment, GitLab
is still the official hub for contributions such as PRs and issues.


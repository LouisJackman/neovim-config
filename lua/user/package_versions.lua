local utils = require 'user.utils'

local function tag(t) return {'tag', t} end
local function commit(c) return {'commit', c} end

return utils.fail_on_missing_lookups {
  ['L3MON4D3/LuaSnip']                            = tag    'v1.0.0',
  ['TimUntersberger/neogit']                      = commit '2a71a5595b49da8a21a20ab8644df9ad0b856ebb',
  ['arcticicestudio/nord-vim']                    = tag    'v0.19.0',
  ['dstein64/nvim-scrollview']                    = tag    'v3.0.3',
  ['folke/trouble.nvim']                          = commit '929315ea5f146f1ce0e784c76c943ece6f36d786',
  ['goolord/alpha-nvim']                          = commit '0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31',
  ['hrsh7th/cmp-buffer']                          = commit '3022dbc9166796b644a841a02de8dd1cc1d311fa',
  ['hrsh7th/cmp-nvim-lsp']                        = commit 'affe808a5c56b71630f17aa7c38e15c59fd648a8',
  ['hrsh7th/nvim-cmp']                            = tag    'v0.0.1',
  ['hrsh7th/vim-vsnip']                           = commit '8f199ef690ed26dcbb8973d9a6760d1332449ac9',
  ['jose-elias-alvarez/null-ls.nvim']             = commit '1ac465b1617b28f753cb875d8ac1d0f23c0b96d4',
  ['kyazdani42/nvim-tree.lua']                    = commit '45d386a3591f87390390c0d718a81e05895465ca',
  ['lewis6991/gitsigns.nvim']                     = tag    'v0.5',
  ['mfussenegger/nvim-dap']                       = tag    '0.3.0',
  ['neovim/nvim-lspconfig']                       = tag    'v0.1.3',
  ['numToStr/Comment.nvim']                       = tag    'v0.6.1',
  ['nvim-lua/plenary.nvim']                       = commit '9e7c62856e47053ec7b17f82c5da0f1e678d92c8',
  ['nvim-lualine/lualine.nvim']                   = commit 'a52f078026b27694d2290e34efa61a6e4a690621',
  ['nvim-telescope/telescope.nvim']               = tag    '0.1.0',
  ['nvim-treesitter/nvim-treesitter']             = commit 'e71dfc1e7a3e7a7782a3c5e62e7de5993149a261',
  ['phaazon/hop.nvim']                            = tag    'v2.0.2',
  ['rcarriga/nvim-dap-ui']                        = tag    'v2.0.0',
  ['romgrk/nvim-treesitter-context']              = commit '8d0759eb798fee2e1201b26c3279713ac67c44c2',
  ['ur4ltz/surround.nvim']                        = commit '633068182cf894480341b992445f0f0d2883721d',
  ['wbthomason/packer.nvim']                      = commit '6afb67460283f0e990d35d229fd38fdc04063e0a',
}


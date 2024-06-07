return {

  {
    'shaunsingh/nord.nvim',
    config = function()
      vim.cmd.colorscheme 'nord'
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'nvim-tree'.setup {
        update_focused_file = {
          enable     = true,
          update_cwd = true,
        },
      }

      vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle, {silent = true})
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'gitsigns'.setup()
    end,
  },
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },

    config = function()
      require 'dapui'.setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
    },

    config = function()
      local set = vim.keymap.set
      set('n', '<leader>ff', function() vim.cmd.Telescope 'find_files' end)
      set('n', '<leader>fg', function() vim.cmd.Telescope 'live_grep' end)
      set('n', '<leader>fb', function() vim.cmd.Telescope 'buffers' end)
      set('n', '<leader>fh', function() vim.cmd.Telescope 'help_tags' end)

      local trouble = require 'trouble'
      require 'telescope'.setup {
        defaults = {
          file_ignore_patterns = {
            '%.git',
            'node_modules',
            'vendor',
            '%.vendor',
            'venv',
            '%.venv',
            'target',
            'build',
            '%.pyc',
            '__pycache__',
            '%.cache',
          },
          mappings = {
            i = { ['<c-t>'] = trouble.open_with_trouble },
            n = { ['<c-t>'] = trouble.open_with_trouble },
          },
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {'nvim-telescope/telescope.nvim'},

    config = function()
      local set = vim.keymap.set
      set('n', '<leader>fu', function() vim.cmd.Telescope 'lsp_references' end, {silent = true})
      set('n', '<leader>gd', function() vim.cmd.Telescope 'lsp_definitions' end, {silent = true})
      set('n', '<leader>rn', vim.lsp.buf.rename, {silent = true})
      set('n', '<leader>xD', function() vim.cmd.Telescope 'lsp_workspace_diagnostics' end, {silent = true})
      set('n', '<leader>xX', function() vim.lsp.Telescope 'lsp_workspace_code_actions' end, {silent = true})
    end,
  },
  'dstein64/nvim-scrollview',
  'L3MON4D3/LuaSnip',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-buffer',
    },

    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        mapping = {
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        },
        sources = {
          { name = 'nvim_lsp' },
        },
      }
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {'neovim/nvim-lspconfig'},
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'lualine'.setup {
        options = {
          theme = 'nord',
        },
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require 'Comment'.setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter'.setup()
      require 'nvim-treesitter.configs'.setup {
        context_commentstring = {
          enable = true,
        },
      }
    end,
  },
  {
    'romgrk/nvim-treesitter-context',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
  },
  {
    'TimUntersberger/neogit',
    dependencies = {'nvim-lua/plenary.nvim'},

    config = function()
      require 'neogit'.setup()
    end,
  },
  {
    'folke/trouble.nvim',
    config = function()
      require 'trouble'.setup {
        fold_open = 'v',
        fold_closed = '>',
        indent_lines = false,
        signs = {
            error = 'error',
            warning = 'warn',
            hint = 'hint',
            information = 'info',
        },
        use_lsp_diagnostic_signs = false,
      }

      local set = vim.keymap.set
      set('n', '<leader>xx', function() vim.cmd 'TroubleToggle' end)
      set('n', '<leader>xw', function() vim.cmd 'TroubleToggle lsp_workspace_diagnostics' end)
      set('n', '<leader>xd', function() vim.cmd 'TroubleToggle lsp_document_diagnostics' end)
      set('n', '<leader>xq', function() vim.cmd 'TroubleToggle quickfix' end)
      set('n', '<leader>xl', function() vim.cmd 'TroubleToggle loclist' end)
      set('n', 'gR', function() vim.cmd 'TroubleToggle lsp_references' end)
    end,
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'folke/trouble.nvim',
      'TimUntersberger/neogit',
      'nvim-telescope/telescope.nvim',
    },

    config = function()
       local alpha = require 'alpha'
       local dashboard = require 'alpha.themes.dashboard'

       dashboard.section.header.val = {
         [[                               __                ]],
         [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
         [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
         [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
         [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
         [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
       }
       dashboard.section.buttons.val = {
         dashboard.button('<cmd> enew <cr>', 'New File', '<cmd>enew <cr>'),
         dashboard.button('<leader> f f', 'Find File', '<cmd>Telescope find_files<cr>'),
         dashboard.button('<leader> f g', 'Live Grep', '<cmd>Telescope live_grep<cr>'),
         dashboard.button('<leader> x x', 'See Errors', '<cmd>TroubleToggle<cr>'),
         dashboard.button('<cmd> Neogit <cr>', 'Git', '<cmd>Neogit<cr>'),
         dashboard.button('<cmd> q <cr>', 'Quit', '<cmd>quit<cr>'),
       }

       alpha.setup(dashboard.opts)
    end,
  },
  {
    'ur4ltz/surround.nvim',
    config = function()
      require 'surround'.setup {
        mappings_style = 'surround',
      }
    end,
  },
  {
    'phaazon/hop.nvim',
    config = function()
      require 'hop'.setup {
        keys = 'etovxqpdygfblzhckisuran',
      }
    end,
  },
}


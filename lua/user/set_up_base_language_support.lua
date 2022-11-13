return function()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd('FileType', {
    pattern = 'lua',
    callback = function() vim.bo.shiftwidth = 2 end,
  })

  autocmd('FileType', {
    pattern = 'go',
    callback = function() vim.bo.expandtab = false end,
  })

  autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.vcl',

    callback = function()

      -- While Varnish's documentation uses 4-space indends, Fastly's variant
      -- uses 2 space-indents.
      vim.bo.shiftwidth = 2

      -- Vim's syntax highlighting of Perl of close enough to VCL for this to
      -- mostly work.
      vim.bo.filetype = 'perl'
    end,
  })

  autocmd({'BufRead', 'BufNewFile'}, {
    pattern = 'Jenkinsfile',

    callback = function()
      vim.bo.filetype = 'groovy'
    end,
  })
end


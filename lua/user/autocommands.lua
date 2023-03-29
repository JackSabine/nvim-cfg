vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _hide_dap_repl
    autocmd FileType dap-repl set nobuflisted
  augroup end

  augroup _dap_repl_cmp
    autocmd FileType dap-repl lua require("dap.ext.autocompl").attach()
  augroup end

  augroup _non_default_indents
    autocmd FileType make,cpp,c,python,json,javascript,jsx,matlab setlocal tabstop=4 shiftwidth=4 softtabstop=4
  augroup end
]])

--

FormatOnSaveEnabled = false

function ToggleFormatOnSave()
  if FormatOnSaveEnabled then
    vim.cmd([[
      autocmd! _lsp_autoformat
    ]])

    print("Disabled format on save")
  else
    vim.cmd([[
      augroup _lsp_autoformat
        autocmd!
        autocmd BufWritePre * lua vim.lsp.buf.format({async=false})
      augroup end
    ]])

    print("Enabled format on save")
  end

  FormatOnSaveEnabled = not FormatOnSaveEnabled
end

ToggleFormatOnSave()

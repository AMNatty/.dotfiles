source ~/.dotfiles/vim-plug/plug.vim

call plug#begin()

Plug 'gpanders/editorconfig.nvim'


Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'ryanoasis/vim-devicons'

Plug 'navarasu/onedark.nvim'

Plug 'romgrk/barbar.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ntpeters/vim-better-whitespace'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

nnoremap <silent> <C-S> <CMD>w<CR>
inoremap <silent> <C-S> <ESC><CMD>w<CR>
" nnoremap <silent> <C-w> <CMD>BufferClose<CR>

" Map Ctrl-Backspace to delete words in insert mode.
nnoremap <C-BS> <C-w>
inoremap <C-BS> <C-O>db

nnoremap <C-DEL> dw
inoremap <C-DEL> <C-O>dw

set backspace=indent,eol,start

set shiftwidth=4
set expandtab
set tabstop=4
set smartindent
set autoindent
set cpoptions+=I
set nowrap
set clipboard+=unnamedplus

set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h12
set number
set whichwrap=<,>,[,]
highlight LineNr ctermfg=darkgray

nnoremap <C-t> <CMD>NERDTreeToggle<CR>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('editorconfig').properties.foo = function(bufnr, val)
  vim.b[bufnr].foo = val
end

require('onedark').setup {
    style = 'deep'
}
require('onedark').load()

END

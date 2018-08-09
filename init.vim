call plug#begin('~/.config/nvim/plugged')

" UI
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jacoborus/tender.vim'
Plug 'Yggdroot/indentLine'

" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive'

" JS support
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'w0rp/ale'

" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'wokalski/autocomplete-flow'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'SirVer/ultisnips'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'

" Rust support
Plug 'rust-lang/rust.vim'

call plug#end()


set ruler
set number
set hlsearch
set splitright
set splitbelow
set colorcolumn=80,120
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set cursorline
set clipboard+=unnamedplus
set hidden
set ignorecase
set smartcase
set relativenumber
set lazyredraw
set scrolloff=10
let g:dracula_colorterm=0
let g:indentLine_color_term=240
colorscheme tender

let $MYVIMRC = '$HOME/.config/nvim/init.vim'
let mapleader = ','

inoremap jj <Esc>
nnoremap <Space> :
nnoremap \ ,


" UltiSnips configs
" let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
" let g:UltiSnipsExpandTrigger = '<nop>'
" inoremap <expr> <CR> pumvisible() ? '<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>' : '\<CR>'


" Deoplete configs
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Statusline configs
let g:lightline = {}
let g:lightline.colorscheme = 'tender'
let g:lightline.component_function = {
\   'gitbranch': 'fugitive#head',
\   'gutentags': 'gutentags#statusline'
\ }
let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
\ }
let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left'
\ }
let g:lightline.active = {
\   'left': [
\     [ 'mode', 'paste' ],
\     [ 'gitbranch', 'readonly', 'filename', 'modified' ]
\   ],
\   'right': [
\     [ 'lineinfo' ],
\     [ 'percent' ],
\     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
\     [ 'gutentags' ]
\   ]
\ }


" Toggle NERDTree
let NERDTreeShowHidden = 1
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>


" Toggle Tagbar
nnoremap <silent> <C-[> :TagbarToggle<CR>


" Commenter configs
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1


" FZF configs
nnoremap <leader>p :Files!<CR>
nnoremap <leader>b :Buffers!<CR>
nnoremap <leader>f :Ag!<CR>
nnoremap <silent> <leader>w :Ag! <C-R><C-W><CR>


" Prettier configs
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync


" Ale configs
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\   'javascript': [ 'eslint', 'flow' ]
\ }
nmap <silent> <leader>aj :ALENext<CR>
nmap <silent> <leader>ak :ALEPrevious<CR>


" EasyMotion configs
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)


" Gutentags configs
" Require universal-ctags
let g:gutentags_ctags_exclude = ['*.min.js', '*.min.css', 'build', 'vendor', '.git', 'node_modules', '*.vim/bundle/*']
let g:gutentags_define_advanced_commands = 1
augroup MyGutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END


" Edit and source configs
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>


" Clear screen
nnoremap <silent> <leader>l :nohlsearch<CR>


" Tmux navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>


" Operator Mono Lig
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic


" Visual bg color for Tender
hi Visual  ctermbg=240

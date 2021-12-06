" Plugins {{{
set nocompatible   " do all the cool vim stuff
filetype plugin on " let plugins handle filetypes

" If vim-plug isn't installed, install it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin plugin stuff here
call plug#begin('~/.vim/plugged')

" Run :PlugInstall to get plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'

" Colorschemes
Plug 'aonemd/kuroi.vim'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call plug#end()
" }}}
" Language Server {{{
let g:coc_global_extensions = ['coc-solargraph', 'coc-python']

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
nmap <silent> <Leader>N <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>n <Plug>(coc-diagnostic-next)

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)
" Show all diagnostics
nnoremap <silent> <Leader>a  :<C-u>CocList diagnostics<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}
" Colors {{{
set t_Co=256
set t_ut=
set termguicolors

colorscheme kuroi   " set the colorscheme
set background=dark " set the background to dark
" }}}
" UI Layout {{{
set number       " show line numbers on left
set showcmd      " show commands at bottom
set cursorline   " highlight current line
set laststatus=2 " always show status line
set ruler        " show position of cursor
set list         " show whitespace characters
set showmatch    " highlight matching braces
set mouse=a      " enable mouse in all modes
set nrformats=   " set decimal over octal
set wildmenu     " show menu when tab completing files
set autoread

" set how whitespace is displayed
set listchars=tab:,.,trail:.,extends:#,nbsp:.

" Netrw config
let g:netrw_banner=0
let g:netrw_winsize=25
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
"}}}
" Fancy Plugin Stuff {{{
" Lightline
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,4'

" Uncomment to use fzf in a floating window
"let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(25)
  let width = float2nr(160)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 2

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

let g:gitgutter_git_executable='/usr/bin/git'
" }}}
" Programming {{{
filetype indent on
set expandtab     " expand tabs to spaces
set autoindent    " set auto indenting
set tabstop=4     " set tabs to 4 spaces
set softtabstop=4 " tab/backspace will insert/delete 4 spaces
set shiftwidth=4  " set autoindent width
set ssop-=options " do not store global and local values in a session
set ssop-=folds   " do not store folds

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

set updatetime=100
set signcolumn=yes
" }}}
" Searching {{{
set hlsearch   " highlight search terms
set ignorecase " case insensitive search
set smartcase  " case sensitive if any capitals
set incsearch
" }}}
" Folding {{{
set foldenable        " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
set foldmethod=syntax " fold on syntaC
" }}}
" Modelines {{{
set modelines=1
" }}}
" Keybindings {{{
map <Space> \
imap jj <Esc>
imap jk <Esc>
imap kk <Esc>

" Map write file to Leader w
nmap <Leader>w <F5>:w<CR>

" Leader y,d,p copies and pastes to clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" New line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" FZF keybindings
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>/ :Rg<Space>
nmap <Leader>* :Rg<Space><C-R><C-W><CR>

" When pasting, go to end of line
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Remove all trailing whitespace by hitting F5
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Tab completion for autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" }}}
" Autogroups {{{
augroup config
    "autocmd BufWritePre * :%s/\s\+$//e
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" }}}
" vim:foldmethod=marker:foldlevel=0

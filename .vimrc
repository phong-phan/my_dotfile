set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'git://git.wincent.com/command-t.git' "File manipulation for Vim
Plugin 'vim-airline/vim-airline' " Status line
Plugin 'vim-airline/vim-airline-themes' "Theme for status line
Plugin 'preservim/nerdtree' "File tree
Plugin 'ryanoasis/vim-devicons' "Icon for file type
Plugin 'sheerun/vim-polyglot' "Language packages
Plugin 'jiangmiao/auto-pairs' "Auto complete bracket
Plugin 'tribela/vim-transparent' "Transparent background in Vim
Plugin 'morhetz/gruvbox' "Gruvbox dark colorscheme for Vim
Plugin 'crusoexia/vim-monokai' "Sublime inspired color scheme
Plugin 'vim-python/python-syntax'
Plugin 'joshdick/onedark.vim' "OneDark color scheme
Plugin 'jeetsukumaran/vim-pythonsense' "Providing text object, motion forPython class
Plugin 'ycm-core/YouCompleteMe' "Auto completion for Vim
Plugin 'frazrepo/vim-rainbow' "Rainbow bracket for Vim
Plugin 'tpope/vim-commentary' "Comment code using gc
Plugin 'Chiel92/vim-autoformat' "Auto formatter for Vim
Plugin 'tarekbecker/vim-yaml-formatter' "YAML formatter
Plugin 'stephpy/vim-yaml' "Speed up YAML for Vim
Plugin 'vim-scripts/AutoComplPop' "Auto popup suggestion in Vim
Plugin 'Yggdroot/indentLine'
Plugin 'mhinz/vim-startify' "Greeting screen when opening Vim without filename
Plugin 'pearofducks/ansible-vim' "Syntax for Ansible in Vim
Plugin 'srcery-colors/srcery-vim' "ColorScheme for Vim
Plugin 'camspiers/animate.vim' "Window resize
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'jez/vim-superman' "Read manpage with Vim instead of less as default
Plugin 'godlygeek/tabular' "Align text plugin
Plugin 'HTML-AutoCloseTag' "Auto close HTML tag
Plugin 'ntpeters/vim-better-whitespace' "Show trailing space in red
Plugin 'Everblush/everblush.vim' "ColorScheme for Vim
Plugin 'camspiers/lens.vim' "Auto windows resize for Vim
Plugin 'othree/html5-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'evanleck/vim-svelte', {'branch': 'main'}
Plugin 'ctrlpvim/ctrlp.vim' "File search
Plugin 'andrewstuart/vim-kubernetes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'hashivim/vim-vagrant'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'christoomey/vim-tmux-navigator' "Vim-Tmux integration
Plugin 'justinmk/vim-sneak' "Faster  naviagtion
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'francoiscabrol/ranger.vim' "Console file manager with Vi-like motion
Plugin 'hrsh7th/vim-vsnip' "Lsp setting for vim
Plugin 'hrsh7th/vim-vsnip-integ' " Combo with above
Plugin 'instant-markdown/vim-instant-markdown'
Plugin 'junegunn/fzf.vim' "Fuzzy finder for Vim
Plugin 'dense-analysis/ale' "Syntax checking for Vim
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
call vundle#end()            " required

filetype plugin indent on    " required
syntax on
set nocompatible
set shiftwidth=4
set tabstop=4
set scrolloff=10
" set ignorecase " Ignore case when doing searching
set cursorline
set hidden " Enable switch between buffers when it is not saved yet.
autocmd ColorScheme * highlight CursorLineNr cterm=bold term=bold gui=bold ctermfg=green
"highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
filetype on
filetype indent on
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
set wrap
set linebreak
set encoding=utf-8
set showcmd
set showmatch
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set smarttab
set hlsearch
set incsearch
set mouse+=a
" set mouse=a
" set mouse=r
set fillchars+=vert:\▏
" set clipboard=unnamedplus
set wildmode=longest:full,full
let g:indentLine_char_list = ['▏']
filetype plugin indent on
autocmd Filetype php syntax on
autocmd Filetype html syntax on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title
if has("vim")
    au BufEnter,TermOpen term://* AcpDisable
    au BufLeave term://* AcpEnable
    "au BufLeave term://* AcpDisable
endif

set termguicolors
" if has("termguicolors")
" endif
"Enable semantic completion after typing two character:
let g:ycm_semantic_triggers = {
	\   'python': [ 're!\w{2}' ]
	\ }
"Registering language server for vim:
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


""Install bash-language server for vim, couple with vim-lsp above:
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'allowlist': ['sh'],
        \ })
endif
"Hide ycm function definition after display 1s from:
"let g:ycm_autoclose_preview_window_after_completion= 1
set completeopt-=preview
set complete=.,b,u,]

" Set the same shape cursor (block) for all mode:
let &t_SI = "\<Esc>[2 q"
let &t_SR = "\<Esc>[2 q"
let &t_EI = "\<Esc>[2 q"

"setting scroll in terminal vim
tnoremap <c-b> <c-\><c-n>

autocmd VimEnter * hi Comment guifg=#9fa49f
highlight Cursor guifg=white guibg=yellow
set background=dark
set guicursor+=n-v-c:blinkon0
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#gabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse=0
let g:airline#extensions#tabline#fnametruncate=0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let python_highlight_all = 1
let g:rainbow_active = 1
hi clear SignColumn


"speed up YAML in Vim:
let g:yaml_limit_spell = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-P>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
" ==================================
" LSP settings just copy from git repo:
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 0         " disable diagnostics support(warning and errors messages.)
let g:lsp_document_highlight_enabled = 0  " Highlight references to the symbol under the cursor (enabled by default)
" Change the style of highlight:
highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green



" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
" ==================================

"map key for better navigation:
" map <F1> : Used to open drop down terminal
map <F2> :NERDTreeToggle<CR>
" Next buffer
map <F3> :bnext<CR>
" Closing a buffer without exiting vim
map <F4> :bdelete!<CR>
" Fzf toggle:
map <F5> :Files<CR>
" Mkdir for path not exists and save the file:
map <F6> :!mkdir -p "%:h"<CR>
map <F7> :Autoformat<CR>
map <F8> :tabNext<CR>
" Match word using Rg
map <F9> :RG<CR>
map <F10> :Ranger<CR>

" Save quit with Ctrl-a
map <C-a> :wq!<CR>
" Quit with Ctrl-w
map <C-w> :q!<CR>

" Map Ctrl-W into just Ctrl for easier typing:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Autocompletion like intellisense:
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Exclude filename from being match when doing grep using Rg:
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"Uncomment this following cmd to autoload NERDTree everytime opening vim
"autocmd VimEnter * NERDTree
" Settings for ALE linting engine:
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = ''
let g:ale_lint_on_text_changed = 'never'

colorscheme onedark
"Turn of notification in vim to avoid duplication with vim-airline.
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar

highlight Comment cterm=italic

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" y do a normal yank, Y do yank into system clipboard
nnoremap Y "+y
vnoremap Y "+y
nnoremap yY ^"+y$
" Pasting content from visual mode without getting buffer overwrite
vnoremap p "_dP

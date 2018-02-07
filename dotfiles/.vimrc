syntax on                                  " Turn on syntax highlighting
filetype plugin indent on                  " Enable automatic filetype detection, filetype-specific plugins/indentation
set encoding=utf8
set nocompatible                           " Don't need to keep compatibility with Vi
set hidden                                 " Allow hiding buffers with unsaved changes
set nolist                                 " Hide invisibles by default
set showcmd                                " Show incomplete cmds down the bottom
set showmode                               " Show current mode down the bottom
set cmdheight=1                            " Make the command line a little taller
set ttyfast                                " More smooth screen redrawing
set incsearch                              " Find the next match as we type the search
set hlsearch                               " Highlight searches by default
set ruler                                  " Show ruler
set number                                 " Show line numbers
set vb t_vb=                               " Turn off bell
set noswapfile                             " Disable creation of *.swp files
set t_Co=256                               " Support for xterm with 256 colors (gets overriden in .gvimrc)
set ignorecase                             " Ignore case by default when searching
set smartcase                              " Switch to case sensitive mode if needle contains uppercase characters
set modelines=1

" Indentation
set expandtab
set shiftwidth=2                           " Number of spaces to use in each autoindent step
set tabstop=2                              " given into the 4 space tab master race -.-
set autoindent
set smartindent

" Wrap
set nowrap                                 " I don't always wrap lines...
set linebreak                              " ...but when I do, I wrap whole words
set wildmenu                               " Make tab completion act more like bash
set wildmode=list:longest                  " Tab complete to longest common string, like bash
set switchbuf=useopen                      " Don't re-open already opened buffers

" Moving around / editing
set nostartofline                          " Avoid moving cursor to BOL when jumping around
set scrolloff=3                            " Keep 3 context lines above and below the cursor
set backspace=2                            " Allow backspacing over autoindent, EOL, and BOL
set showmatch                              " Briefly jump to a paren once it's balanced
set matchtime=2                            " (for only .2 seconds).

" commands
command E Ex

" Remember cursor position
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Persistent Undo
set undodir=$HOME/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Fold settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=99
set foldminlines=0

" Hot Keys
let mapleader = "t"
nmap <Leader>g :tabp<CR>
nmap , <C-w>w

function! TestThisLine(debug)
	let test = matchstr(getline('.'), "\'.*\'")
	if a:debug
		execute "! DEBUG=1 mocha -g " . test
	else
		execute "! mocha -g " . test
	endif
endfunction

function! TestThisFile()
	let test = expand('%:p')
	execute "! mocha " . test
endfunction

function! ShipIt()
  execute "! pandaexpress -f \\\\\\\\VBOXSVR\\\\code\\\\mlb-playstation-app\\\\dist\\\\sony_ps4_trilithium\\\\lithium_ps4.self"
endfunction

function! Protractor()
	let test = expand('%:p')
	execute "! protractor test/conf/protractor.midway.conf.js --specs " . test
endfunction

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! PostThisGist()
  call inputsave()
  let filename = input('Enter Filename: ')
	call inputrestore()

  call inputsave()
  let desc = input('Enter Description: ')
	call inputrestore()

	let body = s:get_visual_selection()
	let data = "{\"description\": \"" . desc . "\", \"public\": true, \"files\": {\"" . filename . "\": {\"content\": \"working\"}}}"
	let cmd = "curl -X POST https://api.github.com/gists -d". data .

  execute '!echo ' . cmd
endfunction

let mapleader = "m"
nmap <Leader>n :call TestThisLine(0)<CR>

nmap <Leader>d :call ShipIt()<CR>

nmap <Leader>f :call TestThisFile()<CR>
nmap <Leader>p :call Protractor()<CR>
vmap <Leader>g :call PostThisGist()<CR>





set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-obsession'
Plugin 'godlygeek/tabular'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'sgur/vim-editorconfig'
Plugin 'vim-syntastic/syntastic'
Plugin 'isRuslan/vim-es6'
call vundle#end()

" let g:snippets_dir = '~/code/dotfiles/vim/snippets'
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript']  = 'javascript/javascript, javascript/javascript-astrolabe'

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'eslint'

filetype on

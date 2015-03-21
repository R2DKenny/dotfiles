" **************************************
" Kenny Y
" 10/23/2014
" **************************************
" **************************************
" * VARIABLES
" **************************************
" Common settings
set nocompatible                " get rid of strict vi compatibility!
set nu                          " line numbering on
set autoindent                  " autoindent on
set noerrorbells                " no error bells
set modeline                    " changes setting based on file
set showmode                    " show the mode on the dedicated line
set nowrap                      " no wrapping
set backspace=2                 " backspace over everything
set background=dark             " set dark background
set exrc                        " open local config files
set nojoinspaces                " don't add white space when combining lines
set backspace=indent,eol,start  " Backspaces over everythin
set ruler                       " which line am I on?
set showcmd                     " show current command
set showmatch                   " Breifely display maching bracket
set bs=2                        " fix backspacing in insert mode
set expandtab                   " replace tab with space
set shiftwidth=4                " determins the number of char per indent
set tabstop=4                   " replaces current tab with specified number
set wrap                        " enable word wrapping
set laststatus=2                " Sets the number of lines at the bottom
set ttimeoutlen=50              " Set delay between mode switching
set history=1000                " Remember more commands and search history
set nobackup                    " Disable backup files
set noswapfile                  " Diable swap files (Caution)
set wildmenu                    " Enable enhanced completion for command mode
set wildmode=longest:full,full  " Completion mode for wildmenu
set wildignore+=*.swp,*.bak,*.dll,*.o,*.obj,*.pyc
set wildignore+=*.jpg,*.gif,*.png,*.class,*.ln
":set mouse=a                    " Enable mouse everywhere
set cursorline                  " Highlight line currently at
"set list                        " Enable visualization of invisible chars
set listchars=tab:>-,trail:-,eol:$,nbsp:% " Characters used to visualize

try
    "colorscheme hybrid              " Set the colorscheme to desert
    colorscheme darknight           " Set the colorscheme to desert
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert              " Set the colorscheme to desert
endtry

set ignorecase                  " search without regards to case
set smartcase                   "
set infercase                   "
set incsearch                   " incremental searching
nnoremap <F6> :set hlsearch!<CR>
nnoremap <F4> :set list!<CR>

" Setting <leader> in case it is changed
let mapleader='\'              " Default <leader> key
let maplocalleader=','         " Default <localleader> key

" Custom keybindings
" Capitalizes a single word in insert mode
inoremap <c-u> <Esc>viwUi
" Shortcut to open the vimrc file for easy editing
nnoremap <leader>ev :e $MYVIMRC<cr>
" Shortcut to source the vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>
" Enable very magic
nnoremap / /\v

" Adjusts the default gvim size
if has("gui_running")
    set lines=35 columns=111
    " If windows gvim, use the following fonts
    if has("win32")
        set guifont=Source_Code_Pro:h9:cANSI,Consolas:h9:cANSI
    else
        set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
    endif
else
    set t_Co=256                    " Enable 256 colors in vim
endif

" Unlimited undo
if has('persistent_undo')
    set undodir=!/.vim/undo
    set undofile
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
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

" Marks the 80 charactor line position regardless of the vim version
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
endif

" Expand tabs in certain files to spaces
au BufRead,BufNewFile *.{c,cpp,h,hpp} set expandtab
au BufRead,BufNewFile *.{c,cpp,h,hpp} set shiftwidth=4
au BufRead,BufNewFile *.{c,cpp,h,hpp} set tabstop=4

au BufRead,BufNewFile *.{java,ml,scala} set expandtab
au BufRead,BufNewFile *.{java,ml,scala} set shiftwidth=4
au BufRead,BufNewFile *.{java,ml,scala} set tabstop=4

au BufRead,BufNewFile *.{py,html} set expandtab
au BufRead,BufNewFile *.{py,html} set shiftwidth=4
au BufRead,BufNewFile *.{py,html} set tabstop=4

" Do not expand tabs in assembly file.  Make them 8 chars wide.
au BufRead,BufNewFile {*.s,Makefile} set noexpandtab
au BufRead,BufNewFile {*.s,Makefile} set shiftwidth=8
au BufRead,BufNewFile {*.s,Makefile} set tabstop=8

" Show syntax
syntax on

" Automatically treat certain files as certain files
au BufRead,BufNewFile *.{markdown,mdown,mkd,mkdn,md} setf markdown
au BufRead,BufNewFile *.jade set syntax=jade " not setf since doctype jams

" For switching between many opened file by using ctrl+l or ctrl+h
map <c-e> :next <CR>
map <C-q> :prev <CR>

" For fixing mixed indentation problems
" Note: gg=G (Move to top of file and fix to the end
map <F7> mzgg=G`z<CR>

" For fixing trailing whitespaces
" Note: :%s/\s\+$//
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Swithing between split window
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Automatic parenthesis cursor adjustment
"imap {} {}<Left>
"imap [] []<Left>
"imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
"imap <> <><Left>
" Do I really need this one?
"imap // //<Left>
" Used for Perl programming
imap /// ///<Left>

" Status bar related
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\

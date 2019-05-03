set encoding=utf-8

" Turn on syntax highlighting
syntax on

" F6 to toggle paste mode
noremap <F6> :set invpaste<CR>
set pastetoggle=<F6>

" Set tabstop to 4 (default)
set tabstop=4

" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

syntax on                             " Syntax highlighting
silent! colorscheme molokai           " Default color scheme. Ignore errors

au BufRead,BufNewFile * start         " Start in INSERT mode
set mouse+=a                          " Allow mouse selection

set backspace=indent,eol,start        " Allow backspacing over everything in insert mode
set laststatus=2                      " Always show status bar

set listchars=nbsp:·,tab:▸\ ,trail:·  " Configure how invisibles appear
set list                              " Show invisibles

set number                            " Show gutter with line numbers
set scrolloff=2                       " Minimum number of lines to always show above/below the caret
set showcmd                           " Show partially typed command sequences
set visualbell                        " Don't beep
set wrap                              " Soft wrap

set nocompatible                      " Not compatible with vi
set esckeys                           " Enables recognition of arrow keys that start with ESC

set nostartofline                     " Prevents the cursor from changing the current column when jumping to other lines in the window
set ww=<,>,h,l                        " Allows you to wrap the cursor on cursor left/right

" Automatically save and reload sessions for files
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Wildmenu (<Tab> command completion)
set wildmenu
set wildmode=longest:list,full

" Indentation
set expandtab                         " Replace tabs with spaces
set shiftwidth=4                      " Spaces used for autoindent and commands like >>
set softtabstop=4                     " Spaces inserted by <Tab>

" Searching
set gdefault                          " Global search by default (/g turns it off)
set hlsearch                          " Highlight results
set incsearch                         " Search-as-you-type
set ignorecase smartcase              " Case-insensitive unless we include uppercase

" Adds <Alt-Up/Down> keys that move a block of text up/down a line
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" Make Ctrl-Q quit
nnoremap <C-q> :q<CR>
inoremap <C-q> <C-o>:q<CR>
vnoremap <C-q> <ESC>:q<CR>

" Make Alt-Q force quit
inoremap <A-q> <C-o>:q!<CR>
nnoremap <A-q> :q!<CR>
vnoremap <A-q> <ESC>:q!<CR>

" Make Ctrl-S save
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
vnoremap <C-s> <ESC>:w<CR>gv

" Make Ctrl-Z undo
nnoremap <C-z> :u<CR>
inoremap <C-z> <C-o>:u<CR>
vnoremap <C-z> <ESC>:i<CR>gv

" Make Ctrl-C copy to the + buffer
vmap <C-c> "+y

" Make Ctrl-V paste from the + register while in cmd mode
nmap <C-v> "+p
" Make Ctrl-V paste from the + register while editing
imap <C-v> <ESC>"+pi
" Make Ctrl-V paste from the + register while in visual mode (doesn't really work)
vmap <C-v> "+p

" More persistent command history
set history=10000

" Hide away backup and swap files
set backupdir=$HOME/.vim/backup/
set directory=$HOME/.vim/swapfiles/

" Enable persistent undo
if has('persistent_undo')         " Check if vim supports it
	set undofile                  " Turn on the feature
	set undodir=$HOME/.vim/undo/  " Directory where the undo files will be stored
endif

" Reload file without prompting if it has changed on disk
" Will still prompt if there is unsaved text in the buffer
set autoread

" Automatically save changes before switching buffer with some
" commands, like :cnfile
set autowrite

set exrc   " Enable per-directory .vimrc files
set secure " Disable unsafe commands in per-directory .vimrc files

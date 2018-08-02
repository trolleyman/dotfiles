set encoding=utf-8

" Turn on syntax highlighting
syntax on

" F11 to toggle paste mode
map <F11> :set invpaste<CR>
set pastetoggle=<F11>

" Set tabstop to 4 (default)
set tabstop=4

syntax on                             " Syntax highlighting
color elflord                         " Default color scheme

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

" More persistent command history
set history=10000

" Hide away backup and swap files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Reload file without prompting if it has changed on disk
" Will still prompt if there is unsaved text in the buffer
set autoread

" Automatically save changes before switching buffer with some
" commands, like :cnfile
set autowrite

set exrc   " Enable per-directory .vimrc files
set secure " Disable unsafe commands in per-directory .vimrc files

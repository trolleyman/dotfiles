
" vim-plug begin
call plug#begin('~/.vim/plugged')

" Color schemes
Plug 'https://github.com/flazz/vim-colorschemes', { 'commit': ' 2f532d0' }

" DetectIdent fork
Plug 'https://github.com/trolleyman/detectindent'

" Rust
Plug 'https://github.com/rust-lang/rust.vim'

" Fish shell
Plug 'https://github.com/dag/vim-fish'

" Fixes some keys with vim
Plug 'https://github.com/trolleyman/vim-fixkey'

" JavaScript
Plug 'https://github.com/pangloss/vim-javascript'

" TOML
Plug 'https://github.com/cespare/vim-toml'

" fakeclip: System clipboard access
Plug 'https://github.com/trolleyman/vim-fakeclip'

" vim-plug end
call plug#end()

"filetype plugin indent on

" DetectIndent
"let g:detectindent_preferred_indent = 4
"autocmd BufReadPost * :DetectIndent


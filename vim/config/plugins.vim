
" vim-plug begin
call plug#begin('~/.vim/plugged')

" Git gutter
Plug 'https://github.com/airblade/vim-gitgutter'
" Update on save
autocmd BufWritePost * GitGutter

" vim-plug end
call plug#end()
"filetype plugin indent on



" Pathogen.vim
" Must turn filetype off and then back on.
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" DetectIndent
let g:detectindent_preferred_indent = 4
autocmd BufReadPost * :DetectIndent

" vim-flake8
let g:flake8_show_in_gutter = 1
" autocmd BufWritePost *.py call Flake8() " This calls flake 8 after each save

" vim-autopep8
"   - Set F8 as the key to call autopep
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_diff_type='vertical'
let g:autopep8_disable_show_diff=1 " Disables showing the diff


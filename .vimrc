syntax on
colorscheme desert

" Configuration for pretty editing. Source: https://lanbugs.de/howtos/linux-tipps-tricks/vim-for-yaml-editing/
set number " activate the line numbering
set ruler
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 et ai	" yaml configuration: tab -> 2 spaces
autocmd FileType json setlocal ts=4 sts=4 sw=4 et ai 		" json configuration: tab -> 4 spaces
" set colorcolumn=80 						" adds a vertical column at position 80
set cursorcolumn " activate a column at a cursor position

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

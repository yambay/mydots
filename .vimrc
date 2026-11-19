" Everything is wrapped in "if 1" so that vim-tiny (no +eval, default `vi` on
" minimal Ubuntu installs) skips it instead of failing with E319 errors.
if 1

set encoding=utf-8
scriptencoding utf-8

" System vimrc files (e.g. macOS) set skip_defaults_vim; load the defaults
" (wildmenu, showcmd, scrolloff, ttimeout, ...) explicitly
unlet! skip_defaults_vim
if filereadable($VIMRUNTIME . '/defaults.vim')
  source $VIMRUNTIME/defaults.vim
endif

colorscheme desert

" defaults.vim enables the mouse on macOS but not on Debian/Ubuntu: set it explicitly
" (empty = terminal selection works as usual; use "a" to enable it in Vim)
set mouse=

" Pretty editing. Source: https://lanbugs.de/howtos/linux-tipps-tricks/vim-for-yaml-editing/
set number
set cursorline
set cursorcolumn " vertical line at the cursor position
set colorcolumn=80 " vertical line at position 80

" Search
set hlsearch
set ignorecase
set smartcase

" Indentation: 4 spaces by default
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4

" Keep swap/undo files out of the working directory
let s:state = expand('~/.vim/state')
if !isdirectory(s:state)
  call mkdir(s:state, 'p', 0700)
endif
set directory=~/.vim/state//
set undofile
set undodir=~/.vim/state//

augroup filetype_settings
  autocmd!
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et ai
  autocmd FileType json setlocal ts=4 sts=4 sw=4 et ai
augroup END

endif

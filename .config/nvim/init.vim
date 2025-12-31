set nocompatible
filetype plugin on
syntax on

" Plugins
call plug#begin()
Plug 'vimwiki/vimwiki'
call plug#end()

" vimrc
if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
endif

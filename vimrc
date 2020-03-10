" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

colorscheme forest-night    " nice colorscheme!
colorscheme desert 	" second preference colorscheme
syntax enable		" enable syntax processing

set tabstop=4		" number of visual 'spaces' per tab character
set softtabstop=4	" number of spaces inserted by pressing tab character
set expandtab		" insert tab characters as spaces
set number		    " show line numbers
set showcmd		    " show command in bottom bar
set cursorline      " highlight current line
filetype plugin on  " filetype-specific plugin use
filetype indent on  " filetype-specific indent style

" FINDING FILES

set path+=**    " search down into subfolders
set wildmenu    " display matching files on tab-completion

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile    " keep an undo file (undo changes after closing)
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

colorscheme desert  " nice colorscheme!
"colorscheme forest-night    " second preference colorscheme
set guifont=Consolas:h11:cANSI:qDRAFT


syntax enable        " enable syntax processing

" adding command to quickly open and edit my vimrc in a new tab
if has('win32')
    command EditRC split ~\vimfiles\vimrc
    " command Erc EditRC
else
    command EditRC split ~/.vim/vimrc
    " command Erc EditRC
endif

" changing leader key to make it easier to reach
let mapleader=","

" FORMATTING OPTIONS
set tabstop=4       " number of visual 'spaces' per tab character
set softtabstop=4   " number of spaces inserted by pressing tab character
set shiftwidth=4    " number of spaces inserted on new line after e.g. curly braces
set expandtab       " insert tab characters as spaces

set number rnu      " show hybrid line numbers (absolute num of current line, relative num of other lines)
set showcmd         " show command in bottom bar
set cursorline      " highlight current line

set breakindent     " wrapped/'broken' lines are indented to the same level as the start of the line
let &showbreak='   '    " sets the indentation of 'broken' lines to two whitespaces ahead of the start of the line
set linebreak       " doesn't break in the middle of words

filetype plugin on  " filetype-specific plugin use
filetype indent on  " filetype-specific indent style

" coc.nvim installation for autocompletion, etc.
call plug#begin()
Plug 'neoclide/coc.nvim'
Plug 'kevinoid/vim-jsonc'
call plug#end()

" FINDING FILES

set path+=**    " search down into subfolders
set wildmenu    " display matching files on tab-completion

" TIDYING SWAP, BACKUP, UNDO AND VIMINFO FILES
if has('win32')
    set directory=%USERPROFILE%\vimfiles\.swp
    set backupdir=%USERPROFILE%\vimfiles\.bkp
    set undodir=%USERPROFILE%\vimfiles\.un
    set viminfo+=n$HOME\\vimfiles\\viminfo
else
    set directory=~/.vim/.swp/
    set backupdir=~/.vim/.bkp/
    set undodir=~/.vim/.un/
    set viminfo+=n~/.vim/viminfo
endif

" OPTIONS FOR `coc` PLUGIN
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use leader-n and leader-p to navigate diagnostics
nmap <silent> ,n <Plug>(coc-diagnostic-next)
nmap <silent> ,p <Plug>(coc-diagnostic-prev)

" set highlighting for popup
highlight Pmenu guibg=SlateBlue ctermbg=LightBlue


" OPTIONS FOR `vim-notes` PLUGIN

let g:notes_directories = ['~/Syncthing/Notes']
let g:notes_suffix = '.note'

" OPTIONS FOR `vimwiki` PLUGIN

let g:vimwiki_list = [{'path': '~/Syncthing/Notes/vimwiki/', 
            \ 'path_html': '~/Syncthing/Notes/vimwiki/html/',
            \ 'syntax': 'markdown', 'ext': '.md',
            \ 'custom_wiki2html': '%USERPROFILE%\Syncthing\Notes\vimwiki\misaka_md2html.py',
            \ 'auto_diary_index': 1 }]

" Adding command to convert to html with pandoc
if has('win32')
    command Pan let fn=expand('%:p:h').'\html\'.expand('%:t:r').'.html' | silent execute '!pandoc --standalone "%" -c pandoc.css -o "'.fn.'" && "'.fn.'"'
    command PanRefresh let fn=expand('%:p:h').'\html\'.expand('%:t:r').'.html' | silent execute '!pandoc --standalone "%" -c pandoc.css -o "'.fn.'"'
else
    command Pan let fn=expand('%:p:h').'/html/'.expand('%:t:r').'.html' | silent execute '!pandoc "%" -o "'.fn.'" && "'.fn.'"'
endif

packloadall

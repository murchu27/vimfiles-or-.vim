set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
call rpcnotify(0, "Gui", "Option", "Popupmenu", 0)

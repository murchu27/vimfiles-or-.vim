" bind Ctrl+Enter to `cargo run`
:nmap <buffer> <C-Enter> :w \| !cargo run<CR>

:set makeprg=cargo\ run\ $*

if exists ('g:loaded_nvimdbt')
    finish
endif

let g:loaded_nvimdbt = 1

command! -nargs=0 DBTrun lua require('nvim-dbt').run()
command! -nargs=0 DBTcompile lua require('nvim-dbt').compile()

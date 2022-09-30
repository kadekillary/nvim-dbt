if exists ('g:loaded_nvimdbt')
    finish
endif

let g:loaded_nvimdbt = 1

command! -nargs=0 DBTrunner lua require('nvim-dbt').runner()
command! -nargs=0 DBTcompiler lua require('nvim-dbt').compiler()

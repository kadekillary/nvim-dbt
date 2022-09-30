local utils = require('nvim-dbt.utils')

local api = vim.api
local fn = vim.fn

local M = {}

function M.runner()
    p, c, f = utils._get_path_parts()

    -- TODO: only chdir if necessary
    -- need to check path and see if they are in dbt project or not
    fn.chdir(c)

    utils._compile_model(f)

    local c_f = utils._get_compiled_file_path(p)

    -- TODO: make this a setup option
    local cmd = {'psql', os.getenv('PSQL'), '-f', c_f}

    utils._run_command(cmd)
end

function M.compiler()
    p, c, f = utils._get_path_parts()

    -- TODO: only chdir if necessary
    -- need to check path and see if they are in dbt project or not
    fn.chdir(c)

    utils._compile_model(f)

    local c_f = utils._get_compiled_file_path(p)

    -- api.nvim_cmd({cmd = 'vsplit', args = c_f})
    api.nvim_command('vsplit ' .. c_f)
end

return M

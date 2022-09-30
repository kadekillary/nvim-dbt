local utils = require("nvim-dbt.utils")

local api = vim.api
local fn = vim.fn

local function _compile_file_and_get_path()
	local path, cwd, file = utils._get_path_parts()

	-- TODO: only chdir if necessary
	-- need to check path and see if they are in dbt project or not
	fn.chdir(cwd)

	-- TODO: change to _run_command()
	utils._compile_model(file)

	local compiled_file_path = utils._get_compiled_file_path(path)

	return compiled_file_path
end

local M = {}

function M.run()
	c_f = _compile_file_and_get_path()

	-- TODO: make this a setup option
	local cmd = { "psql", os.getenv("PSQL"), "-f", c_f }

	utils._run_command(cmd)
end

function M.compile()
	c_f = _compile_file_and_get_path()

	-- TODO: what is up with random empty lines?
	-- TODO: possibly format file before opening split

	api.nvim_command("vsplit " .. c_f)
end

return M

local api = vim.api
local fn = vim.fn

-- local root_dir
-- for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
-- if vim.fn.isdirectory(dir .. "/.git") == 1 then
-- root_dir = dir
-- break
-- end
-- end

local U = {}

function U._get_path_parts()
	local path = fn.expand("%:p")
	local cwd = fn.fnamemodify(path, ":h")
	local file = fn.fnamemodify(path, ":t")
	return path, cwd, file
end

function U._compile_model(file)
	-- TODO: catch errors, -> visualize
	-- TODO: visualize intermediate result
	fn.system("dbt compile --models " .. file)
	if vim.v.shell_error ~= 0 then
		print(vim.v.shell_error)
	end
end

function U._get_compiled_file_path(filepath)
	-- TODO: test
	local proj_path, proj, mod_path = filepath:match("(/.*)(/.*/)(models.*)")
	local compiled_f = proj_path .. proj .. "target/compiled" .. proj .. mod_path
	return compiled_f
end

function U._split_and_write(data)
	-- TODO: remove line numbers
	-- TODO: better filename
	-- #data provides length of a table
	-- ensure stderr doesn't override since table has one
	-- empty string field
	if #data > 1 then
		api.nvim_command("20 split new")
		api.nvim_buf_set_lines(api.nvim_get_current_buf(), 0, -1, false, data)
	end
end

function U._run_command(cmd)
	fn.jobstart(cmd, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			_split_and_write(data)
		end,
		on_stderr = function(_, data)
			_split_and_write(data)
		end,
	})
end

return U

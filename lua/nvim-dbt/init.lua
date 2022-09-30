local nvimdbt = require("nvim-dbt.endpoints")

local M = {}

M.runner = nvimdbt.runner
M.compiler = nvimdbt.compiler

return M

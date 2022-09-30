local nvimdbt = require("nvim-dbt.endpoints")

local M = {}

M.run = nvimdbt.run
M.compile = nvimdbt.compile

return M

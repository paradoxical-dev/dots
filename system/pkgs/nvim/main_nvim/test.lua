local ffi = require("ffi")
local lib = ffi.load(vim.fn.expand("~/.local/sqlite/lib/libsqlite3.so.0"))
print(lib)

-- File and Directory Utilities
local file = {}

function file.toPath(...) return table.concat({...}, '/') end

return file
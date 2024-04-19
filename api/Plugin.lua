---@meta

---@class Plugin
---@field name string
---@field path string
---@field preferences table
Plugin = {}

---@param t {id:string, title:string, group:string, onclick:function, onenabled:fun():boolean}
function Plugin:newCommand(t) end
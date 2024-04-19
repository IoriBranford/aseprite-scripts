---@meta

---@alias WidgetData boolean|string|number

---@class Dialog
---@field data {[string]:WidgetData}
---@field bounds Rectangle
Dialog = {}

---@return Dialog
---@overload fun(title:string):Dialog
---@overload fun(t:{title:string,notitlebar:boolean,parent:Dialog,onclose:function}):Dialog
function Dialog() end

---@param t {id:string, label:string, text:string, selected:boolean, focus:boolean, onclick:function}
---@return Dialog
function Dialog:button(t) end

---@param t {id:string, label:string, text:string, selected:boolean, onclick:function}
---@return Dialog
function Dialog:check(t) end

---By default buttons without an onclick event handler will close the dialog, but if you specify a onclick function, you have to call this function to close the dialog.
---@return Dialog
function Dialog:close() end

---@return Dialog
function Dialog:color() end

---@param t {id:string, label:string, option:string, options:string[], onchange:function}
---@return Dialog
function Dialog:combobox(t) end

---@param t {id:string, label:string, text:string, focus:boolean, onchange:function}
---@return Dialog
function Dialog:entry(t) end

---@param t {id:string, label:string, text:string}
---@return Dialog
function Dialog:label(t) end

---@param t {id:string, visible:boolean?, enabled:boolean?, text:string?}
---@return Dialog
function Dialog:modify(t) end

---@param t {always:boolean}?
---@return Dialog
function Dialog:newrow(t) end

---@param t {id:string, label:string, text:string, decimals:integer, onchange:function}
---@return Dialog
function Dialog:number(t) end

---@param t {id:string, label:string, text:string, selected:boolean, onclick:function}
---@return Dialog
function Dialog:radio(t) end

---@param t {id:string, text:string}
---@return Dialog
function Dialog:separator(t) end

---@return Dialog
function Dialog:shades() end

---@param t {wait:boolean,bounds:Rectangle,autoscrollbars:boolean}?
---@return Dialog
function Dialog:show(t) end

---@param t {id:string, label:string, min:integer, max:integer, value:integer, onchange:function, onrelease:function}
---@return Dialog
function Dialog:slider(t) end

---If called for the first time (or anytime after a Dialog:endtabs call), it creates a new tabs group and starts the first tab. If called after a previous Dialog:tab call, it marks the end of the previous tab and starts a new one.
---Once started a tab, you can define its content by adding widgets as usual. When you are done adding tabs, call Dialog:endtabs.
---@param t {id:string, text:string, onclick:function}
---@return Dialog
function Dialog:tab(t) end

---@param t {id:string, selected:string, align:integer, onchange:function}
---@return Dialog
function Dialog:endtabs(t) end

---@param t { id:string, label:string, title:string, open:boolean, save:boolean, filename:string|string[], filetypes:string[], onchange:function }
---@return Dialog
function Dialog:file(t) end
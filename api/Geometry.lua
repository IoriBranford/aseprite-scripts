---@meta

---@class Point
---@field x number
---@field y number
Point = {}

---@overload fun(x:number, y:number):Point
function Point() end

---@class Size
---@field w number
---@field h number
---@field width number
---@field height number
Size = {}

---@param otherSize Size
---@return Size newSize which will be big enough to contains both given dimensions (self and otherSize).
function Size:union(otherSize) end

---@class Rectangle
---@field x number
---@field y number
---@field w number
---@field h number
---@field width number
---@field height number
---@field origin Point
---@field size Size
---@field isEmpty boolean
Rectangle = {}

---@param x number
---@param y number
---@param w number
---@param h number
---@return Rectangle
---@overload fun(r:Rectangle):Rectangle
---@overload fun(t:{x:number,y:number,w:number,h:number}):Rectangle
---@overload fun(t:{x:number,y:number,width:number,height:number}):Rectangle
---@overload fun(t:number[]):Rectangle
function Rectangle(x, y, w, h) end

---@param otherRectangle Rectangle
---@return boolean
function Rectangle:contains(otherRectangle) end

---@param otherRectangle Rectangle
---@return boolean
function Rectangle:intersects(otherRectangle) end

---@param otherRectangle Rectangle
---@return Rectangle newRectangle which is the intersection of rectangle and otherRectangle. If both rectangles don't intersect each other, the result will be an empty rectangle
function Rectangle:intersect(otherRectangle) end

---@param otherRectangle Rectangle
---@return Rectangle newRectangle which will be a rectangle big enough to contains both given rectangles rectangle and otherRectangle.
function Rectangle:union(otherRectangle) end



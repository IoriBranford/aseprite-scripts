---@meta

---@class Image
---@field id integer
---@field width integer
---@field height integer
---@field bounds Rectangle
---@field cel Cel?
Image = {}

---@overload fun(otherImage:Image, rectangle:Rectangle):Image
function Image() end

---@param sourceImage Image
---@param position Point?
---@param opacity integer?
---@param blendmode BlendMode?
function Image:drawImage(sourceImage, position, opacity, blendmode) end

---@class Cel
---@field sprite Sprite
---@field layer Layer
---@field frame Frame
---@field frameNumber integer the frame number 1 is the first frame (not 0). If you set this property the cel will be moved to the given frameNumber, check the notes of Cel.frame.
---@field image Image
---@field bounds Rectangle
---@field position Point
---@field opacity integer from 0 to 255. The cel is completely transparent when the value is 0; opaque when the value is 255.

---@class Layer
---@field sprite Sprite
---@field name string
---@field opacity integer from 0 to 255. The layer is completely transparent when the value is 0; opaque when the value is 255. When the layer is a background, returns 255.
---@field isImage boolean
---@field cels Cel[]

---@class Frame
---@field sprite Sprite
---@field frameNumber integer 1 is the first frame in the animation and this frame is equal to frame == frame.sprite.frames[frameNumber].
---@field duration number in seconds
---@field previous Frame
---@field next Frame

---@class Tag
---@field sprite Sprite
---@field fromFrame Frame
---@field toFrame Frame
---@field frames integer
---@field name string
---@field anidir AniDir
---@field repeats integer 
---0 = Doesn't specify, plays infinite in UI, once on export, for ping-pong it plays once in each direction
---1 = Plays once, for ping-pong it plays just in one direction
---2 = Plays twice, for ping-pong it plays once in each direction, and once in reverse
---n = Plays N times

---@class Sprite
---@field width number
---@field height number
---@field frames Frame[]
---@field layers Layer[]
---@field filename string
Sprite = {}

---@overload fun(width:number,height:number):Sprite
---@overload fun(width:number,height:number,colorMode:ColorMode):Sprite
function Sprite() end

---@return Layer
function Sprite:newLayer() end

---@return Frame
function Sprite:newEmptyFrame() end

---@param frame integer
function Sprite:deleteFrame(frame) end

---@param layer Layer
---@param frame Frame
---@param image Image?
---@param position Point?
---@return Cel
function Sprite:newCel(layer, frame, image, position) end

---@param fromFrameNumber integer
---@param toFrameNumber integer
---@return Tag
function Sprite:newTag(fromFrameNumber, toFrameNumber) end
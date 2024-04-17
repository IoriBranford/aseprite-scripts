--[[
    Import a character sheet generated by the Universal LPC Character Generator.
    https://sanderfrenken.github.io/Universal-LPC-Spritesheet-Character-Generator/
]]

---@class LPCAnimation
---@field s integer
---@field x integer
---@field y integer
---@field w integer
---@field h integer
---@field parts {[string]: integer[]}?

---@class ImportLPCCharacterArgs
---@field sheet Image
---@field filename string
---@field frametime number in seconds

---@param t ImportLPCCharacterArgs
local function ImportLPCCharacter(t)
    local sheet = t.sheet

    local NormalSpriteSize = 64
    local NormalSheetWidth = 832
    local NormalSheetHeight = 1344

    if sheet.height < NormalSheetHeight or sheet.width < NormalSheetWidth then
        app.alert("Too small.")
        return
    end
    local BigSpriteSize = 128
    local BigWalkWidth = 1152
    local BigSheetHeight = 1856
    local HugeSpriteSize = 192
    local HugeSheetHeight = 3648

    ---@type {[string]:LPCAnimation}
    local Animations = {
        Cast = { s = 64, x = 0, y = 0, w = 448, h = 256 },
        Thrust = { s = 64, x = 0, y = 256, w = 512, h = 256, parts = { Windup = { 0, 3 }, Attack = { 4, 7 } } },
        Stand = { s = 64, x = 0, y = 512, w = 64, h = 256 },
        Walk = { s = 64, x = 64, y = 512, w = 512, h = 256 },
        Swing = { s = 64, x = 0, y = 768, w = 384, h = 256, parts = { Windup = { 0, 2 }, Attack = { 3, 5 } } },
        Shoot = { s = 64, x = 0, y = 1024, w = 832, h = 256, parts = { Windup = { 0, 8 }, Attack = { 9, 11 } } },
        Fall = { s = 64, x = 0, y = 1280, w = 384, h = 64, parts = { Knees = { 0, 2 }, Flat = { 3, 5 } } },
    }

    -- determine the canvas size
    local spriteSize
    if sheet.height >= HugeSheetHeight then
        spriteSize = HugeSpriteSize
        Animations.Swing = { s = 192, x = 0, y = 1344, w = 1152, h = 768, parts = { Windup = { 0, 2 }, Attack = { 3, 5 } } }
        Animations.RevSwing = { s = 192, x = 0, y = 2112, w = 1152, h = 768, parts = { Windup = { 0, 2 }, Attack = { 3, 5 } } }
        Animations.Thrust = { s = 192, x = 0, y = 2880, w = 1536, h = 768, parts = { Windup = { 0, 3 }, Attack = { 4, 7 } } }
    elseif sheet.height >= BigSheetHeight then
        spriteSize = BigSpriteSize

        if sheet.width >= BigWalkWidth then
            Animations.Stand = { s = 128, x = 0, y = 1344, w = 128, h = 512 }
            Animations.Walk = { s = 128, x = 128, y = 1344, w = 1024, h = 512 }
        else
            Animations.Swing = { s = 128, x = 0, y = 1344, w = 768, h = 512, parts = { Windup = { 0, 2 }, Attack = { 3, 5 } } }
        end
    else
        spriteSize = NormalSpriteSize
    end

    local frameDuration = t.frametime
    local sprite = Sprite(spriteSize, spriteSize)
    sprite.filename = t.filename
    local layer = sprite.layers[1]
    local frames = sprite.frames

    local function importAnimation(name, animation, row, dir)
        local columns = math.floor(animation.w / animation.s)
        local sourceRect = Rectangle(animation.x, animation.y + row*animation.s, animation.s, animation.s)
        local dest = Point(spriteSize/2 - animation.s/2, spriteSize/2 - animation.s/2)
        local fromFrameNumber = #frames
        local toFrameNumber = #frames + columns - 1
        app.transaction("Import Animation "..name, function()
            for c = 1, columns do
                local frame = frames[#frames]
                frame.duration = frameDuration
                local image = Image(sheet, sourceRect)
                sprite:newCel(layer, frame, image, dest)

                sourceRect.x = sourceRect.x + animation.s
                sprite:newEmptyFrame()
            end

            local tag = sprite:newTag(fromFrameNumber, toFrameNumber)
            tag.name = name..dir

            local parts = animation.parts
            if parts then
                for part, range in pairs(parts) do
                    tag = sprite:newTag(fromFrameNumber + range[1], fromFrameNumber + range[2])
                    tag.name = name..part..dir
                end
            end
        end)
    end

    for basename, animation in pairs(Animations) do
        local rows = math.floor(animation.h / animation.s)
        if rows <= 1 then
            importAnimation(basename, animation, 0, "")
        else
            for r = 1, rows do
                importAnimation(basename, animation, r-1, rows-r)
            end
        end
    end
end

ImportLPCCharacter({
    sheet = app.image,
    filename = app.fs.filePathAndTitle(app.sprite.filename)..".ase",
    frametime = .05
})
import "CoreLibs/graphics"
import "CoreLibs/object"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Wave Class
class('Waterline').extends(Object)

Waterline.CONFIG = {
}

function Waterline:init()
end

function Waterline:update()
end

function Waterline:draw()
end

local waterline = Waterline()

function playdate.update()
    gfx.clear()
    waterline:update()
    waterline:draw()
end

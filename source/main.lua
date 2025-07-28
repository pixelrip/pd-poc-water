import "CoreLibs/graphics"
import "CoreLibs/object"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Wave Class
class('Waterline').extends(Object)

Waterline.CONFIG = {
    baseY = 2,           -- Base water level Y position
    screenWidth = 400,     -- Playdate screen width
    waves = {
        {frequency = 0.01, amplitude = 2, speed = 0.2},    -- Primary slow wave
        {frequency = 0.05, amplitude = 1, speed = 0.3},   -- Secondary ripple
        {frequency = 0.1, amplitude = 0.5, speed = 0.4},     -- Fine detail wave
        {frequency = 0.15, amplitude = 0.25, speed = 0.5}    -- Surface texture
    }
}

function Waterline:init()
    self.time = 0
    self.waveOffsets = {}
    
    for i = 1, #self.CONFIG.waves do
        self.waveOffsets[i] = 0
    end
end

function Waterline:update()
    self.time = self.time + 1
    
    for i = 1, #self.CONFIG.waves do
        local wave = self.CONFIG.waves[i]
        self.waveOffsets[i] = self.waveOffsets[i] + wave.speed
    end
end

function Waterline:draw()
    for x = 0, self.CONFIG.screenWidth - 1 do
        local y = self.CONFIG.baseY
        
        for i = 1, #self.CONFIG.waves do
            local wave = self.CONFIG.waves[i]
            local waveY = math.sin((x * wave.frequency) + self.waveOffsets[i]) * wave.amplitude
            y = y + waveY
        end
        
        y = math.floor(y)
        gfx.drawLine(x, 0, x, y)
    end
end

local waterline = Waterline()

function playdate.update()
    gfx.clear()
    waterline:update()
    waterline:draw()
end

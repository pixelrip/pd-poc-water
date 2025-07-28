import "CoreLibs/graphics"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Wave Class
Wave = {}
Wave.__index = Wave

function Wave:new(y, octaves, speed, bob_amplitude, bob_speed)
    local wave = {}
    setmetatable(wave, Wave)

    wave.y_position = y
    wave.octaves = octaves
    wave.speed = speed
    wave.bob_amplitude = bob_amplitude
    wave.bob_speed = bob_speed
    
    wave.offset = 0
    wave.bob_offset = 0

    return wave
end

function Wave:update()
    self.offset += self.speed
    self.bob_offset += self.bob_speed
end

function Wave:draw()
    gfx.setLineWidth(1)
    
    local lastX, lastY
    
    local bob = math.sin(self.bob_offset) * self.bob_amplitude
    
    for x = 0, pd.display.getWidth() do
        local y_sum = 0
        for i, octave in ipairs(self.octaves) do
            local angle = (x * octave.frequency) + self.offset
            y_sum += math.sin(angle) * octave.amplitude
        end
        
        local y = self.y_position + y_sum + bob
        
        if lastX then
            gfx.drawLine(lastX, lastY, x, y)
        end
        
        lastX, lastY = x, y
    end
end

-- Create a wave instance with multiple octaves for a more organic feel
local waterLine = Wave:new(
    20, -- Base Y position
    { -- Octaves for wave shape
        {frequency = 0.05, amplitude = 4},
        {frequency = 0.15, amplitude = 1.5}
    },
    0.02, -- Horizontal scroll speed
    2,    -- Bobbing amplitude
    0.01  -- Bobbing speed
)

function playdate.update()
    gfx.clear()

    waterLine:update()
    waterLine:draw()
end

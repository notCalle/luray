--- Base class for light sources
-- The default intensity of the light is 1
-- @classmod Light
-- @see Transformable

local ipairs,rawset = ipairs,rawset
local List = require'lucy.list'
local ShadowRay = require'luray.ray'
local Object = require'lucy.object'
local Transformable = require'luray.transformable'
local M = Object'Light'..Transformable
_ENV = M

--- Intensity
intensity = 1

function M:__init()
    self:__init_transform()
    rawset(self,intensity,self.intensity)
end

--- Calculate lighting for a hit, removing samples in shadow.
--
-- @tparam Hit hit the ray/shape intersection
-- @treturn {struct.lighting,...} visible light samples
function M:lighting(hit)
    local result=List{}
    for _,l in ipairs(self:__lighting(hit)) do
        local shadow=ShadowRay{
            origin = hit.origin,
            direction = l.lightv,
            limit = l.distance
        }:cast(hit.world)
        if not shadow:hit() then result:insert(l) end
    end
    return result
end

--- Abstract metamethods
-- @section

--- Calculate unshadowed lighting for a hit.
-- Returns lighting samples. Lights that produce multiple samples
-- should scale the illumination values appropriately.
--
-- @function __lighting
-- @tparam Hit hit the ray/shape intersection
-- @treturn {struct.lighting,...}

return M

--- An isotropic light source
-- The default position of the light is (0,0,0)
-- @classmod IsotropicLight
-- @see Light
-- @usage
-- Light = require'luray.light.isotropic'

local matrix = require'luray.matrix'
local tau = require'luray'.tau
local position = matrix.point0
local Light = require'luray.light'
local M = Light'IsotropicLight'
_ENV=M

function M:__init()
    Light.__init(self)
end

function M:__lighting(hit)
    local hit_to_lightv = self._transform * position - hit.origin
    local d = hit_to_lightv:norm()
    return {{
        distance = d,
        illumination = self.intensity / (2*tau*d*d),
        lightv = hit_to_lightv/d
    }}
end

return M
